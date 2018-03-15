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
 添加水印

 @param text 水印文字
 @param position  绘制的位置
 */
-(UIImage *)drawText:(NSString *)text position:(CGPoint)position attributes:(NSDictionary *)attributes;





- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;
@end
