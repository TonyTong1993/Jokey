//
//  TYKalmanFilter.h
//  RCTTest
//
//  Created by ZZHT on 2018/5/10.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface KFCoordinate : NSObject
@property (nonatomic,strong) NSDate *timeStamp;
@property (nonatomic,assign) double speed;
@property (nonatomic,assign) double course;
@property (nonatomic,assign) double accuracy;
@property (nonatomic,assign) double latitude;
@property (nonatomic,assign) double longitude;
@end
@interface TYKalmanFilter : NSObject
- (NSArray <KFCoordinate *>*)kalmanFilter:(NSArray <KFCoordinate *>*)locations;

@end
