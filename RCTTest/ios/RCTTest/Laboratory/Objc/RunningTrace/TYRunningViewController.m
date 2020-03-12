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
#import "KalmanFiter.h"
#import "SavitzkyGolay.h"
#import "GaoDeCoorTrans.h"
#import "CoordTrans.h"
@interface TYRunningViewController ()<MAMapViewDelegate,CLLocationManagerDelegate> {
    NSTimer *_internalTimer;
}
@property (nonatomic,weak) MAMapView *mapView;
@property (nonatomic,strong) MATraceManager *traceManager;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableArray *allTrace;
@property (nonatomic,strong) NSMutableArray<KFCoordinate *> *coordinates;
@property (nonatomic,strong) NSMutableArray *tracePoints;
@property (nonatomic,strong) NSMutableArray *traceWithNoSpeedPoints;
@property (nonatomic,strong)  KalmanFiter *kalmanFilter;
@property (nonatomic, strong) MAPolyline *origTrace;
@property (nonatomic, strong) MAPolyline *optimizedTrace;
@property (nonatomic, strong) UISwitch *onTraceSwitch;


@end

@implementation TYRunningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"轨迹优化" style:UIBarButtonItemStylePlain target:self action:@selector(showOptimizedMethods)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self initMapView];
    
    self.onTraceSwitch = [[UISwitch alloc] init];
    self.onTraceSwitch.accessibilityIdentifier = @"origTraceSwitch";
    self.onTraceSwitch.center = CGPointMake(15 + self.onTraceSwitch.bounds.size.width / 2, self.view.bounds.size.height - 90);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.onTraceSwitch.frame) + 5, self.onTraceSwitch.frame.origin.y, 100, CGRectGetHeight(self.onTraceSwitch.bounds))];
    label1.text = @"追踪轨迹";
    [self.view addSubview:label1];
    [self.view addSubview:self.onTraceSwitch];
    
    [self.onTraceSwitch addTarget:self action:@selector(onTrace:) forControlEvents:UIControlEventValueChanged];
    
    
    self.tracePoints = [NSMutableArray array];
    self.allTrace = [NSMutableArray array];
    self.traceWithNoSpeedPoints = [NSMutableArray array];
    self.kalmanFilter = [[KalmanFiter alloc] init];
    _traceManager = [[MATraceManager alloc] init];
    
    //加载本地数据
    [self loadTracePoints];
    [self adapterToTracePoint:self.coordinates];
    [self showTraceInMapView:self.allTrace optimized:false];
    
}
-(void)initMapView {
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    mapView.showsUserLocation = true;
    mapView.userTrackingMode = MAUserTrackingModeFollow;
    mapView.zoomLevel = 15;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    self.mapView = mapView;
}
-(void)dealloc {
    [_internalTimer invalidate];
    _internalTimer = nil;
    [_locationManager stopUpdatingLocation];
}

-(void)showOptimizedMethods {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择优化方案" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //卡尔曼
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"简单卡尔曼" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self removeOptimizedOverlaysInMapView];
        NSArray *coordinates = [self.kalmanFilter kalmanFilterPath:self.coordinates];
        [self adapterToTracePoint:coordinates];
        [self showTraceInMapView:self.allTrace optimized:true];
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"复杂卡尔曼" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self removeOptimizedOverlaysInMapView];
        TYKalmanFilter *kalmanFilter = [TYKalmanFilter new];
        NSArray *coordinates = [kalmanFilter kalmanFilter:self.coordinates];
        [self adapterToTracePoint:coordinates];
        [self showTraceInMapView:self.allTrace optimized:true];
    }];
    
    //五点取一
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"Savitzky-Golay5点1阶" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self removeOptimizedOverlaysInMapView];
         SavitzkyGolay *savitzkyGolay = [SavitzkyGolay new];
        NSArray *coordinates = [savitzkyGolay pathOptimize:self.coordinates];
        [self adapterToTracePoint:coordinates];
        [self showTraceInMapView:self.allTrace optimized:true];
    }];
    //高德地图轨迹纠偏
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"高德地图轨迹纠偏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self removeOptimizedOverlaysInMapView];
        [self correctTraceWithCoordinates:self.coordinates];
        
    }];
    //三点权重纠偏法则
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"三点权重纠偏法则" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self removeOptimizedOverlaysInMapView];
    }];
    
    UIAlertAction *action5 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self removeOptimizedOverlaysInMapView];
    }];
    
    [alertVC addAction:action0];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [alertVC addAction:action4];
    [alertVC addAction:action5];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)onTrace:(UISwitch *)sender
{
    if(sender.isOn) {
        if (!self.locationManager) {
            [self initCLLocationManager];
        }else {
            [self.locationManager startUpdatingLocation];
          
        }
        [self.allTrace removeAllObjects];
        [self startTimer];
    } else {
        if (self.locationManager) {
            [self.locationManager stopUpdatingLocation];
            [_internalTimer invalidate];
            _internalTimer = nil;
        }
    }
}

-(void)drawPolyLine:(MAPolyline *)polyline {
    [self.mapView setVisibleMapRect:polyline.boundingMapRect edgePadding:UIEdgeInsetsMake(30, 70, 30, 50) animated:YES];
    [self.mapView addOverlay:polyline];
    [self.mapView showOverlays:@[polyline] animated:YES];
}
-(void)removeOptimizedOverlaysInMapView {
    if (self.optimizedTrace) {
        [self.mapView removeOverlay:self.optimizedTrace];
    }
}

- (void)loadTracePoints {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"02.txt" ofType:nil];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSString *str = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    NSArray *arr = [str componentsSeparatedByString:@"\n"];

    NSMutableArray *coors = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-mm-dd HH-mm-ss";
    for(NSString *oneLine in arr) {
        NSArray *items = [oneLine componentsSeparatedByString:@","];
        if (items.count < 3) {
            continue;
        }
        NSString *time = [items objectAtIndex:0];
        NSDate *timeStamp = [dateFormatter dateFromString:time];
        double lat = [[items objectAtIndex:1] doubleValue];
        double lon = [[items objectAtIndex:2] doubleValue];
        double speed = [[items objectAtIndex:3] doubleValue];
        double accuracy = [[items objectAtIndex:4] doubleValue];
        double course = [[items objectAtIndex:6] doubleValue];
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(lat, lon);
        CLLocationCoordinate2D amapCoordinate = AMapCoordinateConvert(coor, AMapCoordinateTypeGPS);
        KFCoordinate *coordinate = [KFCoordinate new];
        coordinate.latitude = amapCoordinate.latitude;
        coordinate.longitude = amapCoordinate.longitude;
        coordinate.speed = speed;
        coordinate.accuracy = accuracy;
        coordinate.course = course;
        coordinate.timeStamp = timeStamp;
        [coors addObject:coordinate];
        
    }
    self.coordinates = coors;

}


-(void)showTraceInMapView:(NSArray <MATracePoint *> *)points optimized:(BOOL)isOptimized{
    NSUInteger count = points.count;
    if (count <= 0) {
        return;
    }
    CLLocationCoordinate2D *pCoors = malloc(sizeof(CLLocationCoordinate2D) * count);
    
    for (int i = 0; i < count; i++) {
        CLLocationCoordinate2D *curLoc = pCoors + i;
        MATracePoint *point = points[i];
        curLoc->latitude =point.latitude;
        curLoc->longitude = point.longitude;
    }
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:pCoors count:count];
    if (isOptimized) {
        self.optimizedTrace = polyline;
    }else {
        self.origTrace = polyline;
    }
    [self drawPolyLine:polyline];
    free(pCoors);
    
}
#pragma mark---- Adapter

-(void)adapterToTracePoint:(NSArray <KFCoordinate *>*)coordinates {
    NSMutableArray *results = [NSMutableArray array];
    for (KFCoordinate *coordinate in coordinates) {
        MATracePoint *point = [[MATracePoint alloc] init];
        point.latitude = coordinate.latitude;
        point.longitude = coordinate.longitude;
        [results addObject:point];
    }
    
    self.allTrace = results;
}
-(NSArray <MATraceLocation *> *)adapterToTraceLocation:(NSArray <KFCoordinate *>*)coordinates {
    NSMutableArray *results = [NSMutableArray array];
    for (KFCoordinate *coordinate in coordinates) {
        MATraceLocation *maLoc = [MATraceLocation new];
        maLoc.loc = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
        maLoc.time = [coordinate.timeStamp timeIntervalSince1970]*1000;
        maLoc.speed = coordinate.speed * 3.6;
        maLoc.angle = coordinate.course;
        [results addObject:maLoc];
    }
    
    return results;
}
#pragma mark---- MAMapViewDelegate

-(MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    MAOverlayRenderer *render = nil;
    if ([overlay isKindOfClass:[MAPolyline class]]) {
        render = [[MAPolylineRenderer alloc] initWithPolyline:(MAPolyline *)overlay];
        MAPolylineRenderer  *polylineRenderer =  (MAPolylineRenderer *)render;
        polylineRenderer.lineWidth = 4.f;
        if (overlay == self.origTrace) {
            polylineRenderer.strokeColor = [UIColor greenColor];
        }else {
             polylineRenderer.strokeColor = [UIColor colorWithRed:1.0 green:(int)0xc1/255.0 blue:0x25/255.0 alpha:1.0];
        }
        
        
        
    }
    
    return render;
}


@end

@implementation TYRunningViewController (RecordTrace)
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
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    _locationManager.pausesLocationUpdatesAutomatically = NO;
    if (@available(ios 9.0,*)) {
        _locationManager.allowsBackgroundLocationUpdates = YES;
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


-(void)startTimer {
    __weak typeof(self) weakSelf = self;
    _internalTimer = [NSTimer timerWithTimeInterval:10 block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf) strongSelf  = weakSelf;
        dispatch_queue_t globleQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(globleQueue, ^{
            NSUInteger count = strongSelf.allTrace.count;
            if (count <= 0) return ;
            
            [strongSelf saveTrace:strongSelf.allTrace withFileName:@"all"];
            
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

//实时绘制轨迹时使用
-(MAPolyline *)generatePolyLine:(NSArray <CLLocation *> *)locations {
    NSUInteger count = locations.count;
    if (count <= 0) return nil;
    CLLocationCoordinate2D *pCoords = malloc(sizeof(CLLocationCoordinate2D) * count);
    if(!pCoords) {
        return nil;
    }
    for (int i = 0; i < count; i++) {
        CLLocationCoordinate2D *pCur = pCoords + i;
        CLLocation *location = locations[i];
        CLLocationCoordinate2D amapCoordinate = AMapCoordinateConvert(location.coordinate, AMapCoordinateTypeGPS);
        pCur->latitude = amapCoordinate.latitude;
        pCur->longitude = amapCoordinate.longitude;
    }
    MAPolyline *polyLine = [MAPolyline polylineWithCoordinates:pCoords count:count];
    free(pCoords);
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

#pragma mark--CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *newLocation = [locations lastObject];
    // 建立单点精度参考系
    if (newLocation.horizontalAccuracy > 10 && newLocation.verticalAccuracy > 10) {
        
    }
    
    
    
    
    [self.allTrace addObject:newLocation];
}

@end

@implementation TYRunningViewController (OptimizedMethod)
//通过高德地图进行轨迹纠偏
-(void)correctTraceWithCoordinates:(NSArray <KFCoordinate *>*)coordinates {
    NSArray <MATraceLocation *>* traceLocaions = [self adapterToTraceLocation:coordinates];
    __unused NSOperation *op = [self.traceManager queryProcessedTraceWith:traceLocaions type:-1 processingCallback:^(int index, NSArray<MATracePoint *> *points) {
        NSLog(@"processingCallback");
    } finishCallback:^(NSArray<MATracePoint *> *points, double distance) {
        [self showTraceInMapView:points optimized:true];
    } failedCallback:^(int errorCode, NSString *errorDesc) {
        NSLog(@"error = %@",errorDesc);
    }];
}
@end


