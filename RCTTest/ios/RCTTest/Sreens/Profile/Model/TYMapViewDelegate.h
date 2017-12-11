//
//  TYMapViewDelegate.h
//  RCTTest
//
//  Created by 童万华 on 2017/12/11.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
@interface TYMapViewDelegate : NSObject<MAMapViewDelegate>

-(void)startTimer;
-(void)stopTimer;
@end
