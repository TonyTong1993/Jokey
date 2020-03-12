//
//  TYMapViewDelegate.m
//  RCTTest
//
//  Created by 童万华 on 2017/12/11.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYMapViewDelegate.h"
#import "TYDBTool+TYRunning.h"
@interface TYMapViewDelegate()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *userTracks;
@end
@implementation TYMapViewDelegate
#pragma mark---Getter and Setter
-(NSMutableArray *)userTracks {
    if (!_userTracks) {
        _userTracks = [[NSMutableArray alloc] init];
    }
    return _userTracks;
}
-(void)startTimer {
    _timer = [NSTimer timerWithTimeInterval:3.0f target:self selector:@selector(scheduledTimer) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

-(void)scheduledTimer {
    NSLog(@"%@",[NSThread currentThread]);
    //保存数据
    
    
    
    [_userTracks enumerateObjectsUsingBlock:^(MAUserLocation *obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [[TYDBTool shareInstance] updateUserTrackLocation:obj.location];
    }];

   //清理userTracks
    [_userTracks removeAllObjects];
}
-(void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}
-(void)mapInitComplete:(MAMapView *)mapView {
    [mapView setZoomLevel:17];
    [self startTimer];
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (updatingLocation) {
        [self.userTracks addObject:userLocation];
    }
}
@end
