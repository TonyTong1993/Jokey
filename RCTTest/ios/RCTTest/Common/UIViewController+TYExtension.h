//
//  UIViewController+TYExtension.h
//  RCTTest
//
//  Created by 童万华 on 2017/7/14.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TYExtension)
//获取子视图的父视图
@property (nonatomic,weak,readonly) UIViewController *parentViewController;
//子视图所在的位置
@property (nonatomic,assign) NSInteger currentIndex;
@end
