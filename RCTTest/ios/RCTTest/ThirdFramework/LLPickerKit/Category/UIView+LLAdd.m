//
//  UIView+LLAdd.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UIView+LLAdd.h"
#import <objc/runtime.h>
#import "FunctionDefines.h"

@interface UIView ()

@property (nonatomic, copy) HandleTapBlock handleTapBlock;
@property (nonatomic, copy) HandleTapBlock handleDoubleTapBlock;

@end

@implementation UIView (LLAdd)

- (void)setTop:(CGFloat)t {
    self.frame = CGRectMake(self.left, t, self.width, self.height);
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)b {
    self.frame = CGRectMake(self.left, b - self.height, self.width, self.height);
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLeft:(CGFloat)l {
    self.frame = CGRectMake(l, self.top, self.width, self.height);
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setRight:(CGFloat)r {
    self.frame = CGRectMake(r - self.width, self.top, self.width, self.height);
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setWidth:(CGFloat)w {
    self.frame = CGRectMake(self.left, self.top, w, self.height);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)h {
    self.frame = CGRectMake(self.left, self.top, self.width, h);
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.left, self.top, size.width, size.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

- (UIViewController *)viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
        if ([responder isKindOfClass: [UIViewController class]]) {
            return (UIViewController *)responder;
        }
    return nil;
}

YYSYNTH_DYNAMIC_PROPERTY_OBJECT(handleTapBlock, setHandleTapBlock, COPY_NONATOMIC, HandleTapBlock)
YYSYNTH_DYNAMIC_PROPERTY_OBJECT(handleDoubleTapBlock, setHandleDoubleTapBlock, COPY_NONATOMIC, HandleTapBlock)


- (void)handleTapActionWithBlock:(HandleTapBlock)block {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:[self class] action:@selector(handleTapAction:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];
    self.userInteractionEnabled = YES;
    self.handleTapBlock = block;
}

- (void)handleDoubleTapActionWithBlock:(HandleTapBlock)block {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:[self class] action:@selector(handleDoubleTapAction:)];
    tapGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapGestureRecognizer];
    self.userInteractionEnabled = YES;
    self.handleDoubleTapBlock = block;
}

+ (void)handleTapAction:(UITapGestureRecognizer *)tapGesture {
    Block_exe(tapGesture.view.handleTapBlock, tapGesture.view);
}

+ (void)handleDoubleTapAction:(UITapGestureRecognizer *)tapGesture {
    Block_exe(tapGesture.view.handleDoubleTapBlock, tapGesture.view);
}

- (void)cut:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = radius;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)cut {
    self.clipsToBounds = YES;
    self.layer.cornerRadius = self.width / 2.f;
}

@end
