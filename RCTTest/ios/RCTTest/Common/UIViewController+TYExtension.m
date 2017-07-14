//
//  UIViewController+TYExtension.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/14.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "UIViewController+TYExtension.h"
#import "ScrollPageViewDeleagte.h"
#import <objc/runtime.h>
char TYIndexKey;//动态绑定或获取子视图位置的key
@implementation UIViewController (TYExtension)

-(UIViewController *)parentViewController {
    UIViewController *controller = self;
    while (controller) {
        if ([controller conformsToProtocol:@protocol(ScrollPageViewDeleagte)]) {
            break;
        }
        controller = controller.parentViewController;
    }
    
    return controller;
}


-(void)setCurrentIndex:(NSInteger)currentIndex {
    objc_setAssociatedObject(self, &TYIndexKey, [NSNumber numberWithInteger:currentIndex], OBJC_ASSOCIATION_ASSIGN);
}
-(NSInteger)currentIndex {
    return [objc_getAssociatedObject(self, &TYIndexKey) integerValue];
}
@end
