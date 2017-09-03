//
//  UIImage+Extentions.h
//  SimpleMapGuide
//
//  Created by 童万华 on 2017/3/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extentions)

/** 
 产生一张屏幕截图
 */
+(UIImage *)screenShot;

/**
产生一张视图图片

 @param view 在屏幕中必须渲染
 */
+(UIImage *)imageWithView:(UIView *)view;


/**
 图片添加logo图片

 @param logo logo图
 @param position 绘制的位置
 */
-(UIImage *)drawLogo:(UIImage *)logo position:(CGPoint)position;

/**
 添加水印

 @param text 水印文字
 @param position  绘制的位置
 */
-(UIImage *)drawText:(NSString *)text position:(CGPoint)position attributes:(NSDictionary *)attributes;


/**
 设置图片圆角

 @param radius 圆角半径
 */
-(UIImage *)cornerRadius:(CGFloat)radius;

/**
  设置图片圆角

 @param radius 圆角尺寸
 @param corners 圆角位置
 @return 剪切后的图片
 */
-(UIImage *)cornerRadius:(CGFloat)radius withRoundingCorners:(UIRectCorner)corners;

/**
 伸缩图片

 @param image 原图
 @param size 伸缩尺寸
 @return 伸缩后的图片
 */
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

/**
 画一条屏幕比例下的1像素线

 @param color 线的颜色
 @return 图片
 */
+(UIImage *)singleLineImageWithColor:(UIColor *)color;


@end
