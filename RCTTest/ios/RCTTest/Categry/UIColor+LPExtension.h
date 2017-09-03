//
//  UIColor+LPExtension.h
//  lepaotiyu
//
//  Created by 童万华 on 2017/3/20.
//  Copyright © 2017年 pengdada. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (LPExtension)
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)randomColor;
+ (UIColor *)randomColor:(CGFloat)alpha;
@end
