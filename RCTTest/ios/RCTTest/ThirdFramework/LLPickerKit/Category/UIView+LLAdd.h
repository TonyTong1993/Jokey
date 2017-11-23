//
//  UIView+LLAdd.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HandleTapBlock) (UIView *sender);

@interface UIView (LLAdd)

@property (nonatomic, assign) CGFloat top;

@property (nonatomic, assign) CGFloat bottom;

@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat centerX;

@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

- (UIViewController *)viewController;

/**
 * @brief single tap action
 */
- (void)handleTapActionWithBlock:(HandleTapBlock)block;

/**
 * @brief double tap action
 */
- (void)handleDoubleTapActionWithBlock:(HandleTapBlock)block;

- (void)cut:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

- (void)cut;

@end
