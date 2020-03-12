//
//  TYRunningViewController.h
//  RCTTest
//
//  Created by ZZHT on 2018/5/9.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KFCoordinate;
@interface TYRunningViewController : UIViewController

@end

@interface TYRunningViewController (RecordTrace)
-(void)initCLLocationManager;
-(void)startTimer;
@end

@interface TYRunningViewController (OptimizedMethod)
-(void)correctTraceWithCoordinates:(NSArray <KFCoordinate *>*)coordinates;
@end

