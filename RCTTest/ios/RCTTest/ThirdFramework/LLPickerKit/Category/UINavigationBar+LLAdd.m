//
//  UINavigationBar+LLAdd.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UINavigationBar+LLAdd.h"
#import <objc/runtime.h>
#import "FunctionDefines.h"

@interface UINavigationBar ()

@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation UINavigationBar (LLAdd)

YYSYNTH_DYNAMIC_PROPERTY_OBJECT(backgroundView, setBackgroundView, RETAIN_NONATOMIC, UIView *)

- (void)ll_setBackgroundColor:(UIColor *)color {
    if (!self.backgroundView) {
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.frame = CGRectMake(0, -20, self.bounds.size.width, 20 + self.bounds.size.height);
        [self insertSubview:self.backgroundView atIndex:0];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundView.userInteractionEnabled = NO;
    }
    self.backgroundView.backgroundColor = color;
}

- (void)ll_setWeiXinStyle {
    if (!self.backgroundView) {
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.frame = CGRectMake(0, -20, self.bounds.size.width, 20 + self.bounds.size.height);
        [self insertSubview:self.backgroundView atIndex:0];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundView.userInteractionEnabled = NO;
        
    }
    self.backgroundView.backgroundColor = [UIColor clearColor];
    // 添加渐变色
    CAGradientLayer *gradientlayer = [CAGradientLayer layer];
    gradientlayer.frame = self.backgroundView.bounds;
    [self.backgroundView.layer addSublayer:gradientlayer];
    
    gradientlayer.startPoint = CGPointMake(0, 0);
    gradientlayer.endPoint = CGPointMake(0, 1);
    
    CGFloat const kAlpha = 0.95f;
    CGFloat const kOffset = (1.f - kAlpha) / 14.f;
    
    // 14 count
    NSArray *colors = @[(__bridge id)HEXACOLOR(0x2d2c32, 1 - kOffset * 1).CGColor,
                        (__bridge id)HEXACOLOR(0x2f2e34, 1 - kOffset * 2).CGColor,
                        (__bridge id)HEXACOLOR(0x313036, 1 - kOffset * 3).CGColor,
                        (__bridge id)HEXACOLOR(0x323137, 1 - kOffset * 4).CGColor,
                        (__bridge id)HEXACOLOR(0x343339, 1 - kOffset * 5).CGColor,
                        (__bridge id)HEXACOLOR(0x35343a, 1 - kOffset * 6).CGColor,
                        (__bridge id)HEXACOLOR(0x363639, 1 - kOffset * 7).CGColor,
                        (__bridge id)HEXACOLOR(0x37373a, 1 - kOffset * 8).CGColor,
                        (__bridge id)HEXACOLOR(0x38383b, 1 - kOffset * 9).CGColor,
                        (__bridge id)HEXACOLOR(0x39393c, 1 - kOffset * 10).CGColor,
                        (__bridge id)HEXACOLOR(0x3a393f, 1 - kOffset * 11).CGColor,
                        (__bridge id)HEXACOLOR(0x3b3a40, 1 - kOffset * 12).CGColor,
                        (__bridge id)HEXACOLOR(0x3b3b3e, 1 - kOffset * 13).CGColor,
                        (__bridge id)HEXACOLOR(0x3c3b41, 1 - kOffset * 14).CGColor];
    
    NSArray *locations = @[[NSNumber numberWithDouble:1.f / 14.f],
                           [NSNumber numberWithDouble:2.f / 14.f],
                           [NSNumber numberWithDouble:3.f / 14.f],
                           [NSNumber numberWithDouble:4.f / 14.f],
                           [NSNumber numberWithDouble:5.f / 14.f],
                           [NSNumber numberWithDouble:6.f / 14.f],
                           [NSNumber numberWithDouble:7.f / 14.f],
                           [NSNumber numberWithDouble:8.f / 14.f],
                           [NSNumber numberWithDouble:9.f / 14.f],
                           [NSNumber numberWithDouble:10.f / 14.f],
                           [NSNumber numberWithDouble:11.f / 14.f],
                           [NSNumber numberWithDouble:12.f / 14.f],
                           [NSNumber numberWithDouble:13.f / 14.f],
                           [NSNumber numberWithDouble:14.f / 14.f]];
    
    gradientlayer.colors = colors;
    gradientlayer.locations = locations;
}

- (void)ll_removeUnderline {
    [self setShadowImage:[[UIImage alloc] init]];
}

@end
