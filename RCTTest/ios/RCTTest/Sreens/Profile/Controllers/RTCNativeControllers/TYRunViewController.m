//
//  TYRunViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/9/12.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYRunViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "TYMapViewDelegate.h"
#import "TYMapView.h"
@interface TYRunViewController ()<MAMapViewDelegate>
@property (nonatomic) TYMapViewDelegate *delegate;
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
    TYMapView *mapView = [[TYMapView alloc] initWithFrame:self.view.bounds];
    self.view = mapView;
    [mapView setMapViewDelegate:self.delegate];
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







@end
