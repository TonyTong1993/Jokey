//
//  TYDBTool+TYRunning.h
//  RCTTest
//
//  Created by 童万华 on 2017/9/13.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYDBTool.h"
#import <CoreLocation/CoreLocation.h>
@interface TYDBTool (TYRunning)
-(void)updateUserTrackLocation:(CLLocation *)location;
@end
