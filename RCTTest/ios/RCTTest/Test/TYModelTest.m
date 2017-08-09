//
//  TYModelTest.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/9.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYModelTest.h"
#import "TYImageTest.h"
#import "TYReviewTest.h"
@implementation TYModelTest
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"uid":@"id"};
}
+(NSDictionary *)mj_objectClassInArray {
    return @{@"imgs":[TYImageTest class],@"god_reviews":[TYReviewTest class],@"fine_reviews":[TYReviewTest class]};
}

@end
