//
//  PHAsset+Image.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/9.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "PHAsset+Image.h"

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
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
//    options.progressHandler = ^(double progress, NSError * _Nullable error, BOOL * _Nonnull stop, NSDictionary * _Nullable info) {
//
//    };
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat height = [UIScreen mainScreen].bounds.size.width;
//    CGSize size = CGSizeMake(width/2 , height/2);
    [[PHImageManager defaultManager] requestImageForAsset:self targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        resultHandler(result,info);
    }];
}
@end
