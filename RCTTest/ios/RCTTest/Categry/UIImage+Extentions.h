//
//  UIImage+Extentions.h
//  SimpleMapGuide
//
//  Created by 童万华 on 2017/3/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extentions)
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
