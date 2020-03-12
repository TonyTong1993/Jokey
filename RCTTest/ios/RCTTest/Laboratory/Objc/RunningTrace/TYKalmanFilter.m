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

- (NSArray <KFCoordinate *>*)kalmanFilter:(NSArray <KFCoordinate *>*)locations {
    if (locations.count <= 2) {
        return locations;
    }
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:locations];
    for (int i = 1; i < locations.count; i++) {
        KFCoordinate *lastLoc = locations[i-1];
        KFCoordinate *curLoc = locations[i];
        KFCoordinate *newLocation = [self kalmanFilter:curLoc lastLocation:lastLoc];
        tempArray[i] = newLocation;
    }
    
    return tempArray;
}

- (KFCoordinate *)kalmanFilter:(KFCoordinate *)curLoc lastLocation:(KFCoordinate *)lastloc{
    double newSpeed = curLoc.speed;
    double newLatitude = curLoc.latitude;
    double newLongitude = curLoc.longitude;
    NSDate *newTimeStamp = curLoc.timeStamp;
    double latitude = lastloc.latitude;
    double longitude = lastloc.longitude;
    NSDate *lastTimeStamp = lastloc.timeStamp;
    double duration = [newTimeStamp timeIntervalSinceDate:lastTimeStamp];
    NSDate *timeStamp = lastTimeStamp;
    double newAccuracy = curLoc.accuracy;
    if (duration > 0) {
        variance += duration * newSpeed * newSpeed / 1000;
        timeStamp = newTimeStamp;
    }
    
    double k = variance / (variance + newAccuracy * newAccuracy);
    
    latitude += k * (newLatitude - latitude);
    longitude += k * (newLongitude - longitude);
    variance = (1 - k) * variance;
    
    KFCoordinate *coor = [KFCoordinate new];
    coor.latitude = latitude;
    coor.longitude = longitude;
    coor.accuracy = newAccuracy;
    coor.speed = newSpeed;
    coor.timeStamp = timeStamp;
 
    return coor;
   
}
@end
