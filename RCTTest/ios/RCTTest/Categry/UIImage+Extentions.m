//
//  UIImage+Extentions.m
//  SimpleMapGuide
//
//  Created by 童万华 on 2017/3/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "UIImage+Extentions.h"

@implementation UIImage (Extentions)

//FIXME:需要进行大量测试
+(UIImage *)screenShot{
 //获取根视图控制器
  UIWindow *keyWindow = [[UIApplication sharedApplication].delegate window];
  UIView *screen = keyWindow.rootViewController.view ;
    return [UIImage imageWithView:screen];
}

+(UIImage *)imageWithView:(UIView *)view {
    CGSize size = view.frame.size;
    UIGraphicsBeginImageContextWithOptions(size,NO, [UIScreen mainScreen].scale*2);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage *)drawLogo:(UIImage *)logo position:(CGPoint)position {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale*2);
    //绘制原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //绘制Logo
    [logo drawAtPoint:position];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage *)drawText:(NSString *)text position:(CGPoint)position attributes:(NSDictionary *)attributes{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale*2);
    //绘制原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];

    //绘制Logo
    [text drawAtPoint:position withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(UIImage *)cornerRadius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale*2);
    //绘制原图
  
    UIBezierPath *bezierPath =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) cornerRadius:radius];
    [bezierPath addClip];
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(UIImage *)cornerRadius:(CGFloat)radius withRoundingCorners:(UIRectCorner)corners {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale*2);
    //绘制原图
    UIBezierPath *bezierPath =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.size.width, self.size.height) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    [bezierPath addClip];
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
+(UIImage *)singleLineImageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1/[UIScreen mainScreen].scale,1/[UIScreen mainScreen].scale);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}
@end
