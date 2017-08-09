//
//  TYGodReviewsTest.h
//  RCTTest
//
//  Created by 童万华 on 2017/8/9.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYImageTest.h"
@interface TYReviewTest : NSObject
@property (nonatomic,assign) NSUInteger _id;
@property (nonatomic,assign) NSUInteger pid;
@property (nonatomic,assign) NSUInteger mid;
@property (nonatomic,assign) NSUInteger likes;
@property (nonatomic,assign) NSUInteger up;
@property (nonatomic,assign) NSUInteger down;
@property (nonatomic,assign) BOOL isgod;
@property (nonatomic,assign) NSUInteger subreviewcnt;
@property (nonatomic,assign) NSUInteger status;
@property (nonatomic,assign) NSUInteger disp;
@property (nonatomic,copy) NSString *review;
@property (nonatomic,copy) NSArray *imgs;
@property (nonatomic,copy) NSString *mname;
@property (nonatomic,assign) NSUInteger avatar;
@property (nonatomic,assign) NSUInteger gender;
@end
