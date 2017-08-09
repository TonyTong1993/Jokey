//
//  UIColor+RGBA.m
//  RCTTest
//
//  Created by 童万华 on 17/8/5.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "UIColor+RGBA.h"

@implementation UIColor (RGBA)

+(NSArray *)colorForRGBAWithConvertColor:(UIColor *)color {
  CGFloat numberOfComponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbaComponents ;
    if (numberOfComponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbaComponents = [NSArray arrayWithObjects:@(components[0]),@(components[1]),@(components[2]),@(components[3]), nil];
    }else if (numberOfComponents == 2) {
        if (CGColorEqualToColor(color.CGColor, [UIColor clearColor].CGColor)) {
            rgbaComponents = [NSArray arrayWithObjects:@(0.0),@(0.0),@(0.0),@(0),nil];
        }
        if (CGColorEqualToColor(color.CGColor, [UIColor blackColor].CGColor)) {
            rgbaComponents = [NSArray arrayWithObjects:@(0),@(0), @(0), @(1),nil];
        }
        if (CGColorEqualToColor(color.CGColor, [UIColor whiteColor].CGColor)) {
            rgbaComponents = [NSArray arrayWithObjects:@(1),@(1),@(1),@(1),nil];
        }
        if (CGColorEqualToColor(color.CGColor, [UIColor grayColor].CGColor)) {
            rgbaComponents = [NSArray arrayWithObjects:@(0.5),@(0.5),@(0.5),@(1),nil];
        }
        if (CGColorEqualToColor(color.CGColor, [UIColor lightGrayColor].CGColor)) {
            rgbaComponents = [NSArray arrayWithObjects:@(0.667),@(0.667),@(0.667),@(1),nil];
        }
        if (CGColorEqualToColor(color.CGColor, [UIColor darkGrayColor].CGColor)) {
            rgbaComponents = [NSArray arrayWithObjects:@(0.333),@(0.333),@(0.333),@(1),nil];
        }

    }
    return rgbaComponents;
}
+(NSArray *)colorForGradientRGBAWith:(NSArray *)normalRgbaComponents selectedRgbaComponents:(NSArray*)selectedRgbaComponents {
    NSArray *gradientRGBAArr;
    if (normalRgbaComponents && selectedRgbaComponents) {
        CGFloat deltaR = [normalRgbaComponents[0] floatValue] - [selectedRgbaComponents[0] floatValue];
        CGFloat deltaG = [normalRgbaComponents[1] floatValue] - [selectedRgbaComponents[1] floatValue];
        CGFloat deltaB = [normalRgbaComponents[2] floatValue] - [selectedRgbaComponents[2] floatValue];
        CGFloat deltaA = [normalRgbaComponents[3] floatValue] - [selectedRgbaComponents[3] floatValue];
        gradientRGBAArr = [NSArray arrayWithObjects:@(deltaR), @(deltaG), @(deltaB), @(deltaA), nil];
    }
    return gradientRGBAArr;
}

+(UIColor *)oldColorWithSelectedColorRGBA:(NSArray*)selectedColorRGBA deltaRGBA:(NSArray*)deltaRGBA scale:(CGFloat)scale
{
    return [UIColor colorWithRed:[selectedColorRGBA[0] floatValue] + [deltaRGBA[0] floatValue] * scale green:[selectedColorRGBA[1] floatValue] + [deltaRGBA[1] floatValue] * scale blue:[selectedColorRGBA[2] floatValue] + [deltaRGBA[2] floatValue] * scale alpha:[selectedColorRGBA[3] floatValue] + [deltaRGBA[3] floatValue] * scale];
}
+(UIColor *)newColorWithNormalColorRGBA:(NSArray*)normalColorRGBA deltaRGBA:(NSArray*)deltaRGBA scale:(CGFloat)scale
{
    return [UIColor colorWithRed:[normalColorRGBA[0] floatValue] - [deltaRGBA[0] floatValue] * scale green:[normalColorRGBA[1] floatValue] - [deltaRGBA[1] floatValue] * scale blue:[normalColorRGBA[2] floatValue] - [deltaRGBA[2] floatValue] * scale alpha:[normalColorRGBA[3] floatValue] - [deltaRGBA[3] floatValue] * scale];
}

@end
