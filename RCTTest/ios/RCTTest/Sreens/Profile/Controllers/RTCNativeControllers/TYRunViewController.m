//
//  TYRunViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/9/12.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYRunViewController.h"
<<<<<<< HEAD
//#import <MAMapKit/MAMapKit.h>
#import "TYDBTool+TYRunning.h"
@interface TYRunViewController ()//<MAMapViewDelegate>
//@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) NSMutableArray *userTrack;
@property (nonatomic,strong) NSTimer *timer;
=======
#import <MAMapKit/MAMapKit.h>
#import "TYMapViewDelegate.h"
#import "TYMapView.h"
@interface TYRunViewController ()<MAMapViewDelegate>
@property (nonatomic) TYMapViewDelegate *delegate;
>>>>>>> origin/dev
@end

@implementation TYRunViewController
#pragma mark---getter and setter
-(TYMapViewDelegate *)delegate {
    if (!_delegate) {
        _delegate = [[TYMapViewDelegate alloc] init];
    }
    return _delegate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< HEAD
    
    // Do any additional setup after loading the view.
//    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:_mapView];
//    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
//    _mapView.showsUserLocation = YES;
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
//    _mapView.desiredAccuracy = kCLLocationAccuracyBest;
//    _mapView.delegate = self;
//    MAUserLocationRepresentation *r = [[MAUserLocationRepresentation alloc] init];
//    r.showsAccuracyRing = NO;///精度圈是否显示，默认YES
//    r.showsHeadingIndicator = NO;///是否显示方向指示(MAUserTrackingModeFollowWithHeading模式开启)。默认为YES
//    r.fillColor = [UIColor redColor];///精度圈 填充颜色, 默认 kAccuracyCircleDefaultColor
//    r.strokeColor = [UIColor blueColor];///精度圈 边线颜色, 默认 kAccuracyCircleDefaultColor
//    r.lineWidth = 2;///精度圈 边线宽度，默认0
//    r.locationDotBgColor = [UIColor greenColor];///定位点背景色，不设置默认白色
//    [self.mapView updateUserLocationRepresentation:r];
=======
    TYMapView *mapView = [[TYMapView alloc] initWithFrame:self.view.bounds];
    self.view = mapView;
    [mapView setMapViewDelegate:self.delegate];
>>>>>>> origin/dev
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_delegate stopTimer];
}
-(void)dealloc {
    NSLog(@"%s",__func__);
}

<<<<<<< HEAD
//-(void)mapInitComplete:(MAMapView *)mapView {
//    [mapView setZoomLevel:19];
//    //开启计时器
//    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(handleUserTrackData) userInfo:nil repeats:YES];
//
//}
//-(void)handleUserTrackData {
//
//
//    for (MAUserLocation *userLocation in self.userTrack) {
//        @autoreleasepool {
//
//            [[TYDBTool shareInstance] updateUserTrackLocation:userLocation.location];
//
//        }
//    }
//    self.userTrack = nil;
//}
//
//-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
//
//    if (updatingLocation) {
//        [self.userTrack addObject:userLocation];
////        NSLog(@"userLoaction = %@",[userLocation description]);
//
//    }else {
////         NSLog(@"updatingLocation= false-userLoaction = %@",[userLocation description]);
//    }
//}
=======





>>>>>>> origin/dev

@end
