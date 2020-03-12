//
//  TYMapVIew.m
//  RCTTest
//
//  Created by 童万华 on 2017/12/11.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYMapView.h"

@interface TYMapView()
@property (nonatomic) MAMapView *mapView;
@end
@implementation TYMapView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Do any additional setup after loading the view.
        _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
        [self addSubview:_mapView];
        ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    return self;
}

-(void)setMapViewDelegate:(id<MAMapViewDelegate>)delegate {
    self.mapView.delegate = delegate;
}

@end
