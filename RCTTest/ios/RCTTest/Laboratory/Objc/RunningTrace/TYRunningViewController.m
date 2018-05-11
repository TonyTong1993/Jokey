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
#import "GaoDeCoorTrans.h"
@interface TYRunningViewController ()<MAMapViewDelegate,CLLocationManagerDelegate> {
    NSTimer *_internalTimer;
}
@property (nonatomic,weak) MAMapView *mapView;
@property (nonatomic,strong) MATraceManager *traceManager;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableArray *allTrace;
@property (nonatomic,strong) NSMutableArray *tracePoints;
@property (nonatomic,strong) NSMutableArray *traceWithNoSpeedPoints;
@property (nonatomic,strong) TYKalmanFilter *kalmanFilter;
@property (nonatomic, strong) MAPolyline *origTrace;
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
    self.allTrace = [NSMutableArray array];
    self.traceWithNoSpeedPoints = [NSMutableArray array];
    self.kalmanFilter = [[TYKalmanFilter alloc] init];
    [self loadTracePoints];
    [self initOriginalTrace];
   
//    [self initCLLocationManager];
}
-(void)dealloc {
    [_internalTimer invalidate];
    _internalTimer = nil;
    [_locationManager stopUpdatingLocation];
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
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
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
//    [self startTimer];
    [_locationManager startUpdatingLocation];
    _locationManager.delegate = self;
    
    _traceManager = [MATraceManager sharedInstance];
    [_traceManager startTraceWith:^(NSArray<CLLocation *> *locations, NSArray<MATracePoint *> *tracePoints, double distance, NSError *error) {
        
    }];
    
    
    
}
- (void)initOriginalTrace {
    CLLocationCoordinate2D *pCoords = malloc(sizeof(CLLocationCoordinate2D) * self.allTrace.count);
    if(!pCoords) {
        return;
    }
    
    for(int i = 0; i < self.allTrace.count; ++i) {
        KFCoordinate *p = [self.allTrace objectAtIndex:i];
        CLLocationCoordinate2D *pCur = pCoords + i;
        pCur->latitude = p.latitude;
        pCur->longitude = p.longitude;
    }
    
    self.origTrace = [MAPolyline polylineWithCoordinates:pCoords count:self.allTrace.count];
    if(pCoords) {
        free(pCoords);
    }
}

-(void)startTimer {
    __weak typeof(self) weakSelf = self;
    _internalTimer = [NSTimer timerWithTimeInterval:10 block:^(NSTimer * _Nonnull timer) {
        NSLog(@"进行数据校验");
        __strong typeof(weakSelf) strongSelf  = weakSelf;
        dispatch_queue_t globleQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globleQueue, ^{
            NSUInteger count = strongSelf.allTrace.count;
            if (count <= 0) return ;
            
            [strongSelf saveTrace:strongSelf.allTrace withFileName:@"all"];
            [strongSelf saveTrace:strongSelf.tracePoints withFileName:@"speed"];
            [strongSelf saveTrace:strongSelf.traceWithNoSpeedPoints withFileName:@"nosp"];
            MAPolyline *polyline = [strongSelf generatePolyLine:strongSelf.allTrace];
            if(!polyline) {
                return;
            }
           
            dispatch_async(dispatch_get_main_queue(), ^{
               
            });
            
        });
    } repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_internalTimer forMode:NSRunLoopCommonModes];
    [_internalTimer fire];
}
-(NSMutableString *)generateLocationInfo:(NSArray <CLLocation *> *)locations {
    
    NSMutableString *mInfo = [NSMutableString new];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-mm-dd HH:mm:ss";
    for (CLLocation *location in locations) {
        NSString *dateString = [dateFormatter stringFromDate:location.timestamp];
        NSString *info = [NSString stringWithFormat:@"%@,%lf,%lf,%f,%f,%f,%f\n",dateString,location.coordinate.latitude,location.coordinate.longitude, location.speed,location.horizontalAccuracy,location.verticalAccuracy,location.course];
        [mInfo appendString:info];
        
    }
    
    return mInfo;
}
-(MAPolyline *)generatePolyLine:(NSArray <CLLocation *> *)locations {
    NSUInteger count = locations.count;
    if (count <= 0) return nil;
    MAMapPoint *points = malloc(sizeof(MAMapPoint) *count);
    for (int i = 0; i < count; i++) {
        
        CLLocation *location = locations[i];
        CGPoint point = [GaoDeCoorTrans transform:location.coordinate.latitude lon:location.coordinate.longitude];//MAMapPointForCoordinate(location.coordinate);
        MAMapPoint *curPoint = points + 1;
        curPoint->x = point.x;
        curPoint->y = point.y;
    }
    MAPolyline *polyLine = [MAPolyline polylineWithPoints:points count:count];
    free(points);
    return polyLine;
}
-(void)saveTrace:(NSArray <CLLocation *>*)locations withFileName:(NSString *)fileName{
    NSMutableString *info = [self generateLocationInfo:locations];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-mm-dd HH:mm:ss";
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    NSString *name = [NSString stringWithFormat:@"%@-%@.txt",fileName,dateString];
    NSString *path = [[UIApplication sharedApplication].documentsPath stringByAppendingPathComponent:name];
    NSError *error = nil;
    BOOL success  = [info writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSAssert(success, [error localizedDescription]);
    }
    
}

-(void)drawPolyLine:(MAPolyline *)polyline {
    [self.mapView setVisibleMapRect:polyline.boundingMapRect edgePadding:UIEdgeInsetsMake(30, 70, 30, 50) animated:YES];
    [self.mapView addOverlay:polyline];
    [self.mapView showOverlays:@[polyline] animated:YES];
}
- (void)loadTracePoints {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"trace.txt" ofType:nil];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    NSArray *arr = [str componentsSeparatedByString:@"\n"];
    NSMutableArray *results = [NSMutableArray array];
    for(NSString *oneLine in arr) {
        NSArray *items = [oneLine componentsSeparatedByString:@","];
        
        if(items.count == 3) {
            NSString *lat = [items objectAtIndex:1];
            NSString *lon = [items objectAtIndex:2];
            KFCoordinate *point = [[KFCoordinate alloc] init];
            point.latitude = [lat doubleValue];
            point.longitude = [lon doubleValue];
            [results addObject:point];
        }
    }
    
    self.allTrace = results;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"current locations count = %lu",locations.count);
    CLLocation *curLoc = [locations lastObject];
    if (curLoc.speed > 1) { //运动状态
        
        [self.tracePoints addObject:curLoc];
        
    }else { //静止状态
        [self.traceWithNoSpeedPoints addObject:curLoc];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-mm-dd HH:mm:ss";
        NSString *dateString = [dateFormatter stringFromDate:curLoc.timestamp];
        NSString *info = [NSString stringWithFormat:@"%@,%lf,%lf,%f,%f,%f,%f\n",dateString,curLoc.coordinate.latitude,curLoc.coordinate.longitude, curLoc.speed,curLoc.horizontalAccuracy,curLoc.verticalAccuracy,curLoc.course];
        NSLog(@"%@",info);
    }
    [self.allTrace addObject:curLoc];
}

-(void)mapInitComplete:(MAMapView *)mapView {
    [self drawPolyLine:self.origTrace];
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
