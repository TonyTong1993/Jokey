//
//  PHAssetCollection+Poster.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/8.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "PHAssetCollection+Poster.h"
static CGFloat const kDefaultThumbnailWidth = 100;
@implementation PHAssetCollection (Poster)
-(void)posterImage:(void (^)(UIImage *, NSDictionary *))resultHandler {
    CGSize const defaultSize = CGSizeMake(kDefaultThumbnailWidth, kDefaultThumbnailWidth);
    [self posterImage:defaultSize resultHandler:resultHandler];
}
-(void)posterImage:(CGSize)targetSize resultHandler:(void (^)(UIImage *, NSDictionary *))resultHandler {
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:self options:nil];
    if (fetchResult.count > 0) { } else {
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        PHAsset *asset = fetchResult.lastObject;
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = CGSizeMake(targetSize.width * scale, targetSize.height * scale);
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                resultHandler(result, info);
            });
        }];
    });
}
+ (NSString *)replaceEnglishAssetCollectionNamme:(NSString *)englishName {
    if([englishName isEqualToString:@"My Photo Stream"]) {
        return @"我的照片流";
    }
    if([englishName isEqualToString:@"Selfies"]) {
        return @"自拍";
    }
    if([englishName isEqualToString:@"Bursts"]) {
        return @"连拍";
    }
    if([englishName isEqualToString:@"Screenshots"]) {
        return @"屏幕快照";
    }
    if([englishName isEqualToString:@"Favorites"]) {
        return @"喜欢";
    }
    if([englishName isEqualToString:@"Recently Added"]) {
        return @"最近添加";
    }
    if([englishName isEqualToString:@"Videos"]) {
        return @"视频";
    }
    if([englishName isEqualToString:@"Panoramas"]) {
        return @"全景";
    }
    if([englishName isEqualToString:@"Camera Roll"]) {
        return @"相机胶卷";
    }
    if([englishName isEqualToString:@"Recently Deleted"]) {
        return @"最近删除";
    }
    return englishName;
}
@end
