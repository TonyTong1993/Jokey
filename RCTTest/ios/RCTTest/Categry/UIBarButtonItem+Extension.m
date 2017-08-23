//
//  UIBarButtonItem+Extension.m
//  lepaotiyu
//
//  Created by pengdada on 16/9/20.
//  Copyright © 2016年 pengdada. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)barBtnItemWithNormalIconName:(NSString *)normalIconName
                              highlightIconName:(NSString *)highlightIconName
                              target:(id)target
                              action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *nmlImage = [UIImage imageNamed:normalIconName];
    [btn setImage:nmlImage forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightIconName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
+ (instancetype)barBtnItemWithNormalIcon:(UIImage *)normalIcon
                           highlightIcon:(UIImage *)highlightIcon
                                  target:(id)target
                                  action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:normalIcon forState:UIControlStateNormal];
    [btn setImage:highlightIcon forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}

@end
