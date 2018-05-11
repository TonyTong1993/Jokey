//
//  TYKalmanFilter.m
//  RCTTest
//
//  Created by ZZHT on 2018/5/10.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYKalmanFilter.h"

@implementation KFCoordinate

@end

@interface TYKalmanFilter(){
    double variance;
}
@end
@implementation TYKalmanFilter

-(instancetype)init {
    self = [super init];
    if (self) {
        variance = -1;
    }
    return self;
}

- (NSArray <CLLocation *>*)kalmanFilter:(NSArray <CLLocation *>*)locations {
    if (locations.count <= 2) {
        return locations;
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:locations];
    for (int i = 1; i < locations.count; i++) {
        CLLocation *lastLoc = locations[i-1];
        CLLocation *curLoc = locations[i];
        CLLocation *newLocation = [self kalmanFilter:curLoc lastLocation:lastLoc];
        tempArray[i] = newLocation;
    }
    
    return tempArray;
}

- (CLLocation *)kalmanFilter:(CLLocation *)curLoc lastLocation:(CLLocation *)lastloc{
    double newSpeed = curLoc.speed;
    double newLatitude = curLoc.coordinate.latitude;
    double newLongitude = curLoc.coordinate.longitude;
    NSDate *newTimeStamp = curLoc.timestamp;
    double latitude = lastloc.coordinate.latitude;
    double longitude = lastloc.coordinate.longitude;
    NSDate *lastTimeStamp = lastloc.timestamp;
    double duration = [newTimeStamp timeIntervalSinceDate:lastTimeStamp];
    NSDate *timeStamp = lastTimeStamp;
    double newAccuracy = curLoc.horizontalAccuracy;
    if (duration > 0) {
        variance += duration * newSpeed * newSpeed / 1000;
        timeStamp = newTimeStamp;
    }
    
    double k = variance / (variance + newAccuracy * newAccuracy);
    
    latitude += k * (newLatitude - latitude);
    longitude += k * (newLongitude - longitude);
    variance = (1 - k) * variance;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    CLLocation *newLocation = [[CLLocation alloc] initWithCoordinate:coordinate altitude:0 horizontalAccuracy:newAccuracy verticalAccuracy:0 course:0 speed:newSpeed timestamp:timeStamp];
  
    return newLocation;
   
}
@end
