//
//  UIColor+RGBA.h
//  RCTTest
//
//  Created by 童万华 on 17/8/5.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RGBA)
+(NSArray *)colorForRGBAWithConvertColor:(UIColor *)color;

+(NSArray *)colorForGradientRGBAWith:(NSArray *)normalRgbaComponents selectedRgbaComponents:(NSArray*)selectedRgbaComponents;

+(UIColor *)oldColorWithSelectedColorRGBA:(NSArray*)selectedColorRGBA deltaRGBA:(NSArray*)deltaRGBA scale:(CGFloat)scale;

+(UIColor *)newColorWithNormalColorRGBA:(NSArray*)normalColorRGBA deltaRGBA:(NSArray*)deltaRGBA scale:(CGFloat)scale;
@end
