//
//  TYMapView.h
//  RCTTest
//
//  Created by 童万华 on 2017/12/11.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
@interface TYMapView : UIView
-(void)setMapViewDelegate:(id<MAMapViewDelegate>)delegate;
@end
