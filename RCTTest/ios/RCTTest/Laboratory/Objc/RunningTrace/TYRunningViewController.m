//
//  TYRunningViewController.m
//  RCTTest
//
//  Created by ZZHT on 2018/5/9.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYRunningViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "MBProgressHUD+MJ.h"
#import "TYKalmanFilter.h"
@interface TYRunningViewController ()<MAMapViewDelegate,CLLocationManagerDelegate> {
    NSTimer *_internalTimer;
}
@property (nonatomic,weak) MAMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableArray *tracePoints;
@property (nonatomic,strong) TYKalmanFilter *kalmanFilter;
@end

@implementation TYRunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    mapView.showsUserLocation = true;
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    mapView.zoomLevel = 15;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    
    self.tracePoints = [NSMutableArray array];
    self.kalmanFilter = [[TYKalmanFilter alloc] init];
    [self initCLLocationManager];
}

-(void)initCLLocationManager {
    
    if (![CLLocationManager locationServicesEnabled]) {
        [MBProgressHUD showError:@"定位服务为开启"];
        return;
    }
    if (![CLLocationManager headingAvailable]) {
        [MBProgressHUD showError:@"不支持设备朝向服务的监听"];
    }
    if (![CLLocationManager significantLocationChangeMonitoringAvailable]) {
        [MBProgressHUD showError:@"不支持重要位置改变的监听"];
    }
    
    if (![CLLocationManager isMonitoringAvailableForClass:[CLRegion class]]) {
        [MBProgressHUD showError:@"不支持指定区域改变的监听"];
    }
    _locationManager = [CLLocationManager new];
    _locationManager.activityType = CLActivityTypeFitness;
    _locationManager.distanceFilter = 10;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    if (@available(ios 9.0,*)) {
        //        _locationManager.allowsBackgroundLocationUpdates = YES;
    }
    if (@available(ios 11.0,*)) {
        _locationManager.showsBackgroundLocationIndicator = YES;
    }
    if (@available(ios 8.0,*)) {
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
    _locationManager.delegate = self;
    
    
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
-(void)startTimer {
    __weak typeof(self) weakSelf = self;
    _internalTimer = [NSTimer timerWithTimeInterval:5*60 block:^(NSTimer * _Nonnull timer) {
               NSLog(@"进行数据校验");
        __strong typeof(weakSelf) strongSelf  = weakSelf;
        dispatch_queue_t globleQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globleQueue, ^{
            NSUInteger count = strongSelf.tracePoints.count;
            MAMapPoint *points = malloc(sizeof(MAMapPoint) * count);
            int i = 0;
            NSMutableString *mInfo = [NSMutableString new];
            NSArray *locations = [strongSelf.kalmanFilter kalmanFilter:strongSelf.tracePoints];
            for (CLLocation *location in locations) {
                MAMapPoint point =  MAMapPointForCoordinate(location.coordinate);
                MAMapPoint *curPoint = points + i;
                curPoint->x = point.x;
                curPoint->y = point.y;
                i++;
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                dateFormatter.dateFormat = @"yyyy-mm-dd HH:mm:ss";
                NSString *dateString = [dateFormatter stringFromDate:location.timestamp];
                NSString *info = [NSString stringWithFormat:@"%@,%lf,%lf,%f,%f,%f\n",dateString,location.coordinate.latitude,location.coordinate.longitude, location.speed,location.horizontalAccuracy,location.verticalAccuracy];
                [mInfo appendString:info];
                
            }
            //保存文件
            NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
            NSString *fileName = [NSString stringWithFormat:@"%lf.txt",timeStamp];
            NSString *path = [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:fileName];
            NSError *error = nil;
            BOOL success  = [mInfo writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
            if (error) {
                NSAssert(success, [error localizedDescription]);
            }
              MAPolyline *polyline = [MAPolyline polylineWithPoints:points count:count];
            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.mapView addOverlay:polyline];
                [strongSelf.mapView showOverlays:@[polyline] animated:YES];
                [strongSelf.tracePoints removeAllObjects];
            });
           
//            [timer invalidate];
        });
    } repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_internalTimer forMode:NSRunLoopCommonModes];
    [_internalTimer fire];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *curLoc = [locations lastObject];
    if (curLoc.speed > 0) {
        NSLog(@"speed > 0");
        [self.tracePoints addObject:curLoc];
        
    }
}

-(void)mapInitComplete:(MAMapView *)mapView {
    
}

-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    MAOverlayRenderer *render = nil;
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        render = [[MAPolylineRenderer alloc] initWithPolyline:(MAPolyline *)overlay];
        MAPolylineRenderer  *polylineRenderer =  (MAPolylineRenderer *)render;
        polylineRenderer.lineWidth = 4.f;
        polylineRenderer.strokeColor = [UIColor greenColor];
    }
    
    return render;
}

@end
