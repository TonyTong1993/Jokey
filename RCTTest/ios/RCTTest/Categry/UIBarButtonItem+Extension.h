//
//  UIBarButtonItem+Extension.h
//  lepaotiyu
//
//  Created by pengdada on 16/9/20.
//  Copyright © 2016年 pengdada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)barBtnItemWithNormalIconName:(NSString *)normalIconName
                           highlightIconName:(NSString *)highlightIconName
                                      target:(id)target
                                      action:(SEL)action;

+(instancetype)barBtnItemWithNormalIcon:(UIImage *)normalIcon
                           highlightIcon:(UIImage *)highlightIcon
                                  target:(id)target
                                  action:(SEL)action;

@end
