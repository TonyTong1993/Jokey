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
-(UIImage *)drawText:(NSString *)text position:(CGPoint)position;

-(UIImage *)drawAttributedText:(NSAttributedString *)attributedText position:(CGPoint)position;

/**
 设置图片圆角

 @param radius 圆角半径
 */
-(UIImage *)cornerRadius:(CGFloat)radius;












+(UIImage*)convertViewToImage:(UIView*)view;

/**
 添加

 @param imageLogo src图片
 @return dist图片
 */
-(UIImage *)imageWithLogo:(UIImage *)imageLogo;

/**
 将文字添加到图片的指定位置上

 @param text 文字内容
 @param point 位置信息
 @return 带有文字的图片
 */
-(UIImage *)imageWithText:(NSString *)text position:(CGPoint)point attributes:(NSDictionary *)attributes lineWidth:(CGFloat)width;

/**
 添加图片到目标图片上

 @param image scrImage
 @param position 添加的位置
 @return dist图片
 */
-(UIImage *)addImage:(UIImage *)image position:(CGPoint)position;

/**
 生成圆形图片

 @param image src图片
 @return dist图片
 */
+ (instancetype)circleImage:(NSString *)image;

/**
 生成圆角图片

 @param image src图片
 @param size 生成图片尺寸
 @param radius 圆角半径
 @return dist图片
 */
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)radius;
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
- (UIImage *)getResizeImageWithSize:(CGSize )size;
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength;
+(UIImage *)singleLineImageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor1:(UIColor *)color size:(CGSize)size;

@end
