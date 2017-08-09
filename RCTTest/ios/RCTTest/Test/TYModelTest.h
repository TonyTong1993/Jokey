//
//  TYModelTest.h
//  RCTTest
//
//  Created by 童万华 on 2017/8/9.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TYModelTest : NSObject
@property (nonatomic,assign) NSUInteger uid;
@property (nonatomic,assign) NSUInteger mid;
@property (nonatomic,copy)   NSString *content;
@property (nonatomic,assign) NSUInteger reviews;
@property (nonatomic,assign) NSUInteger likes;
@property (nonatomic,assign) NSUInteger up;
@property (nonatomic,copy)   NSArray *imgs;
@property (nonatomic,assign) NSUInteger status;
@property (nonatomic,assign) NSUInteger share;
@property (nonatomic,assign) NSUInteger type;
@property (nonatomic,copy)   NSDictionary *member;
@property (nonatomic,copy)   NSDictionary *topic;
@property (nonatomic,copy)   NSArray *god_reviews;
@property (nonatomic,copy)   NSArray *fine_reviews;
@end
