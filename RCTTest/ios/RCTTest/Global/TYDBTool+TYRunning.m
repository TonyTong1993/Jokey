//
//  TYDBTool+TYRunning.m
//  RCTTest
//
//  Created by 童万华 on 2017/9/13.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYDBTool+TYRunning.h"
@implementation TYDBTool (TYRunning)
-(void)updateUserTrackLocation:(CLLocation *)location {
    NSString *sql = [NSString stringWithFormat:@"insert into user_track_table (latitude,longitude) values (%lf,%lf)",location.coordinate.latitude,location.coordinate.longitude];
   BOOL success = [self.db executeUpdate:sql];
    NSAssert(success, @"更新用户位置信息失败");
}
@end
