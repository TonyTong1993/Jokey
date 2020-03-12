//
//  UIViewController+MobClick.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/2.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "UIViewController+MobClick.h"
#import <YYKit/NSObject+YYAdd.h>
#import <UMAnalytics/MobClick.h>
@implementation UIViewController (MobClick)
+(void)load {
    [self swizzleClassMethod:@selector(viewWillAppear:) with:@selector(exchange_viewWillAppear:)];
    [self swizzleClassMethod:@selector(viewWillDisappear:) with:@selector(exchange_viewWillDisappear:)];
}
-(void)exchange_viewWillAppear:(BOOL)animated {
    [self exchange_viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}
-(void)exchange_viewWillDisappear:(BOOL)animated {
    [self exchange_viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}
@end
