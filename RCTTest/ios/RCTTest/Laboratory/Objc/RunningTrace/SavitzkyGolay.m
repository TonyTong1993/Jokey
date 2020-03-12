//
//  SavitzkyGolay.m
//  RCTTest
//
//  Created by ZZHT on 2018/5/15.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "SavitzkyGolay.h"
#import "TYKalmanFilter.h"
@implementation SavitzkyGolay
-(NSArray<KFCoordinate *> *)pathOptimize:(NSArray<KFCoordinate *> *)originlist {
    NSUInteger count = originlist.count;
    if (count < 5) {
        
        return originlist;
    }
    NSMutableArray *list = [NSMutableArray arrayWithArray:originlist];
    NSUInteger mutiple = count / 5;
    
    for (int i = 0; i < mutiple; i++) {
        NSRange range = NSMakeRange(5 * i, 5);
        NSArray *subArray = [list subarrayWithRange:range];
        [self optimizeTracePoints:subArray];
    }
    
    return originlist;
}
-(void)optimizeTracePoints:(NSArray<KFCoordinate *> *)points {
    int size = (int)points.count;
    
    //优化纬度
  
    points[0].latitude = (3*points[0].latitude + 2*points[1].latitude + points[2].latitude - points[4].latitude)/5.0;
    points[1].latitude = (4*points[0].latitude + 3*points[1].latitude + 2*points[2].latitude  + points[3].latitude)/10.0;
    points[size-2].latitude = (4*points[size-1].latitude + 3*points[size-2].latitude + 2*points[size-3].latitude  + points[size-4].latitude)/10.0;
    points[size-1].latitude = (3*points[size-1].latitude + 2*points[size-2].latitude + 1*points[size-3].latitude  - points[size-5].latitude)/5.0;
    
    //优化经度
    
    points[0].longitude = (3*points[0].longitude + 2*points[1].longitude + points[2].longitude - points[4].longitude)/5.0;
    points[1].longitude = (4*points[0].longitude + 3*points[1].longitude + 2*points[2].longitude  + points[3].longitude)/10.0;
    points[size-2].longitude = (4*points[size-1].longitude + 3*points[size-2].longitude + 2*points[size-3].longitude  + points[size-4].longitude)/10.0;
    points[size-1].longitude = (3*points[size-1].longitude + 2*points[size-2].longitude + 1*points[size-3].longitude  - points[size-5].longitude)/5.0;
    
}


@end
