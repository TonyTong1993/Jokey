//
//  UIImage+Extentions.m
//  SimpleMapGuide
//
//  Created by 童万华 on 2017/3/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "UIImage+Extentions.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define equal_Width SCREEN_WIDTH/375
#define equal_Heigh SCREEN_HEIGHT/667
#define   ThimeBackFont   (([[[UIDevice currentDevice] systemVersion] floatValue])   >   (8.0)   ?   (@"KohinoorDevanagari-Light")   :   ([UIFont systemFontOfSize:10].fontName))
@implementation UIImage (Extentions)
+(UIImage*)convertViewToImage:(UIView*)view{
    CGSize s = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale*2);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 合成乐跑的logo

 @param imageLogo logo图标
 @return 合成图片
 */
-(UIImage *)imageWithLogo:(UIImage *)imageLogo {
    CGFloat logoH = 74;//logoSize.height * scale * equal_Width;
    CGFloat logoW = 74;//logoSize.width * scale * equal_Width;
    CGFloat margin = 5;
    
    UIGraphicsBeginImageContextWithOptions(self.size,NO,0.0);
    //原始图片渲染
    [self drawInRect:CGRectMake(0, 0, self.size.width , self.size.height)];
    CGFloat logoX = 20;
    CGFloat logoY = self.size.height - logoH - 24;
    CGRect rect = CGRectMake(logoX, logoY, logoW, logoH);
    [imageLogo drawInRect:rect];
    //绘制文字
    NSString *waterString = @"步道探秘";
    CGFloat textX = logoX+logoW+margin*2;
    CGFloat textY = logoY+margin*2;
    
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]};
   CGSize textSize = [waterString boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    CGRect react = CGRectMake(textX, textY, textSize.width, textSize.height);
    [waterString drawInRect:react withAttributes:attributes];
    //绘制additional 文字
    NSString *addition = @"让运动从此妙趣横生";
    CGFloat additionX = logoX+logoW+margin*2;
    CGFloat additionY = textY+margin*2+3+textSize.height;
    NSDictionary *addtionAttributes = @{NSFontAttributeName:[UIFont fontWithName:ThimeBackFont size:14],NSForegroundColorAttributeName:[UIColor blackColor]};
    CGSize additionSize = [addition boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:addtionAttributes context:nil].size;
    [addition drawInRect:CGRectMake(additionX, additionY, additionSize.width, additionSize.height) withAttributes:addtionAttributes];
    // 从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(UIImage *)imageWithText:(NSString *)text position:(CGPoint)point attributes:(NSDictionary *)attributes lineWidth:(CGFloat)width{
    
    if (!attributes) {
        attributes = @{NSFontAttributeName:[UIFont fontWithName:ThimeBackFont size:28],NSForegroundColorAttributeName:[UIColor blackColor]};
    }
    UIGraphicsBeginImageContextWithOptions(self.size,NO,0.0);
    //原始图片渲染
    [self drawInRect:CGRectMake(0, 0, self.size.width , self.size.height)];
    CGFloat textX = point.x;
    CGFloat textY = point.y;
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    CGRect react = CGRectMake(textX, textY, textSize.width, textSize.height);
    [text drawInRect:react withAttributes:attributes];
    // 从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(UIImage *)addImage:(UIImage *)image position:(CGPoint)position{
    CGSize size = image.size;
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGRect tmpReact = CGRectMake(position.x, position.y, width, height);
    //原始图片渲染
    UIGraphicsBeginImageContextWithOptions(self.size,NO,0.0);
    [self drawInRect:CGRectMake(0, 0, self.size.width , self.size.height)];
    [image drawInRect:tmpReact];
    // 从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (instancetype)circleImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)circleImage:(NSString *)image
{
    return [[self imageNamed:image] circleImage];
}
static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,
                                 float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 0); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 0); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)radius
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}
- (UIImage *)getResizeImageWithSize:(CGSize )size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context,
    UIGraphicsBeginImageContext(CGSizeMake(floor(size.width),floor(size.height)));
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}
+ (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 0.1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}
+(UIImage *)singleLineImageWithColor:(UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

+ (UIImage *)imageWithColor1:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <=0 || size.height <=0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
