//
//  PHAsset+Image.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/9.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "PHAsset+Image.h"
#import "UIImage+Extentions.h"
@implementation PHAsset (Image)
-(void)requestThumbnailWithTargetSize:(CGSize)targetSize complicationhandler:(void (^)(UIImage *result, NSDictionary *))resultHandler {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = CGSizeMake(targetSize.width * scale, targetSize.height * scale);
        [[PHImageManager defaultManager] requestImageForAsset:self targetSize:size contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultHandler(result, info);
            });
        }];
    });
}
-(void)getPreViewImage:(void (^)(UIImage *result, NSDictionary *))resultHandler {
    PHImageRequestOptions *options = [PHImageRequestOptions new];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    options.networkAccessAllowed = YES;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGSize targetSize = CGSizeMake(width/3, height/3);
    [[PHImageManager defaultManager] requestImageForAsset:self targetSize:targetSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        if (result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultHandler(result,info);
            });
        }
    }];
}

-(void)requestImage:(CGSize)targetSize options:(PHImageRequestOptions *)options{
    
    //targetSize adapt
    CGFloat aspectRatio = self.pixelWidth / (CGFloat)self.pixelHeight;
    CGFloat pixelWidth = targetSize.width * [UIScreen mainScreen].scale * 1.5;
    
    //超宽图片
    if (aspectRatio > 1.8) {
        pixelWidth = pixelWidth * aspectRatio;
    }
    //超高图片
    if (aspectRatio < 0.2) {
        pixelWidth = pixelWidth / 0.5;
    }
    CGFloat pixelHeight = pixelWidth / aspectRatio;
    
    [[PHImageManager defaultManager] requestImageForAsset:self targetSize:targetSize contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
    }];
}
@end
