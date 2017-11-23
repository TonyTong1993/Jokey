//
//  LLImageHandler.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/17.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLImageHandler.h"
#import "Config.h"
static CGFloat const kDefaultThumbnailWidth = 100;
@interface LLImageHandler ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, weak) PHPhotoLibrary *photoLibrary;
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@end

@implementation LLImageHandler

#pragma mark -
#pragma mark - 获取授权状态
+ (LLAuthorizationStatus)requestAuthorization {
    if (iOS8Upwards) {
        return (LLAuthorizationStatus)[PHPhotoLibrary authorizationStatus];
    }
    return (LLAuthorizationStatus)[ALAssetsLibrary authorizationStatus];
}

+ (void)requestAuthorization:(void(^)(LLAuthorizationStatus status))handler {
    if (iOS8Upwards) {
        handler((LLAuthorizationStatus)[PHPhotoLibrary authorizationStatus]);
        return;
    }
    handler((LLAuthorizationStatus)[ALAssetsLibrary authorizationStatus]);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (iOS8Upwards) {
            self.photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
        } else {
            self.assetsLibrary = [[ALAssetsLibrary alloc] init];
        }
        self.concurrentQueue = dispatch_queue_create("com.LLImageHandler.global", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

#pragma mark -
#pragma mark - 获取所有相册
/** 获取所有相册(iOS8及以下)
 * @brief result 的元素类型为 PHAssetCollection
 */
- (void)enumerateALAssetsGroupsWithResultHandler:(void(^)(NSArray <ALAssetsGroup *>*result))resultHandler {
    __block NSMutableArray *groups = [NSMutableArray array];
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group.numberOfAssets > 0) {
            [groups addObject:group];
            
        } else {
            // 主线程回调
            [groups sortUsingComparator:^NSComparisonResult(ALAssetsGroup *obj1, ALAssetsGroup * obj2) {
                return  [obj1 numberOfAssets] < [obj2 numberOfAssets];
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                Block_exe(resultHandler, groups);
            });
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

/** 获取所有相册(iOS8及以上)
 * @brief result 的元素类型为 PHAssetCollection
 */
- (void)enumeratePHAssetCollectionsWithResultHandler:(void(^)(NSArray <PHAssetCollection *>*result))resultHandler {
    // 照片群组数组
    NSMutableArray *groups = [NSMutableArray array];
    
    dispatch_sync(self.concurrentQueue, ^{
        // 获取系统相册
        PHFetchResult <PHAssetCollection *>*systemAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        // 获取用户自定义相册
        PHFetchResult <PHAssetCollection *>*userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
        
        for (PHAssetCollection *collection in systemAlbums) {
            // 过滤照片数量为0的相册
            if ([collection numberOfAssets] > 0) {
                [groups addObject:collection];
            }
        }
        
        for (PHAssetCollection *collection in userAlbums) {
            // 过滤照片数量为0的相册
            if ([collection numberOfAssets] > 0) {
                [groups addObject:collection];
            }
        }
        //排序相册
        [groups sortUsingComparator:^NSComparisonResult(PHAssetCollection *obj1, PHAssetCollection * obj2) {
            return  [obj1 numberOfAssets] < [obj2 numberOfAssets];
        }];
    });
    
    dispatch_sync(self.concurrentQueue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            Block_exe(resultHandler, groups);
        });
    });
}

/** 获取所有相册(兼容iOS8及iOS8)
 * @brief 如果iOS系统是8.0或以上, 则 result 的元素类型为 PHAssetCollection, 否则为 ALAssetsGroup
 */
- (void)enumerateGroupsWithFinishBlock:(void(^)(NSArray *result))finishBlock {
    if (iOS8Upwards) {
        [self enumeratePHAssetCollectionsWithResultHandler:finishBlock];
    } else {
        [self enumerateALAssetsGroupsWithResultHandler:finishBlock];
    }
}

#pragma mark -
#pragma mark - 获取某一相册下所有图片资源
/** 获取所有在assetsGroup中的asset(iOS8以下)
 * @param assetsGroup: 照片群组
 */
- (void)enumerateAssetsInAssetsGroup:(ALAssetsGroup *)group finishBlock:(void(^)(NSArray <ALAsset *>*result))finishBlock {
    __block NSMutableArray *assets = [NSMutableArray array];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
       
        if (result) {
            // 过滤图片
            if ([[result valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypePhoto]) {
//                ALAssetRepresentation *re = [result representationForUTI:(__bridge NSString *)kUTTypeGIF];
//                if (!re) {//过滤GIF
                    [assets addObject:result];
//                }
            }
        } else {
            // 主线程回调
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(assets);
            });
        }
    }];
}

/** 获取所有在assetCollection中的asset(iOS8以上)
 * @param assetCollection: 照片群组
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)collection finishBlock:(void(^)(NSArray <PHAsset *>*result))finishBlock {
    __block NSMutableArray <PHAsset *>*results = [NSMutableArray array];
    dispatch_async(self.concurrentQueue, ^{
        // 获取collection这个相册中的所有资源
        PHFetchResult <PHAsset *>*assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //过滤GIF图片
            PHImageRequestOptions *options = [PHImageRequestOptions new];
            options.resizeMode = PHImageRequestOptionsResizeModeFast;
            options.synchronous = YES;
            [[PHImageManager defaultManager] requestImageDataForAsset:obj
                                                                     options:options
                                                               resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
//                                                                   if ([info[@"PHImageFileUTIKey"] isEqualToString:(__bridge NSString *)kUTTypeGIF]) {
//                                                                       //gif
//                                                                   }else {
                                                                       if (obj.mediaType == PHAssetMediaTypeImage) {
                                                                           [results addObject:obj];
                                                                       }
//                                                                   }
                                                                  
                                                               }];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{            
            finishBlock(results);
        });
    });
}

/** 获取所有在相册group中的assets (兼容iOS8 及 iOS8)
 * @param group: 相册
 * @param finishBlock: 完成回调
 */
- (void)enumerateAssetsInGroup:(id)group finishBlock:(void(^)(NSArray *result))finishBlock {
    if (!group) {
        return;
    }
    if ([group isKindOfClass:[PHAssetCollection class]]) {
        [self enumerateAssetsInAssetCollection:group finishBlock:finishBlock];
    } else if ([group isKindOfClass:[ALAssetsGroup class]]) {
        [self enumerateAssetsInAssetsGroup:group finishBlock:finishBlock];
    }
}

@end

@implementation PHAssetCollection (LLAdd)

- (void)posterImage:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
    CGSize const defaultSize = CGSizeMake(kDefaultThumbnailWidth, kDefaultThumbnailWidth);
    [self posterImage:defaultSize resultHandler:resultHandler];
}

- (void)posterImage:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
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
                Block_exe(resultHandler, result, info);
            });
        }];
    });
}

- (NSInteger)numberOfAssets {
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    // 注意 %zd 这里不识别，直接导致崩溃
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeImage];
    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:self options:fetchOptions];
    return result.count;
}
-(void)setAssetCount:(NSUInteger)assetCount {
    
}
@end

@implementation PHAsset (LLAdd)

- (void)thumbnail:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
    CGSize const defaultSize = CGSizeMake(kDefaultThumbnailWidth, kDefaultThumbnailWidth);
    [self thumbnail:defaultSize resultHandler:resultHandler];
}

- (void)thumbnail:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = CGSizeMake(targetSize.width * scale, targetSize.height * scale);
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageForAsset:self targetSize:size contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                Block_exe(resultHandler, result, info);
            });
        }];
    });
}
//TODO:优化从icloud下载的体验
- (void)original:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        PHImageRequestOptions *originRequestOptions = [[PHImageRequestOptions alloc] init];
        originRequestOptions.version = PHImageRequestOptionsVersionCurrent;
        originRequestOptions.networkAccessAllowed = YES;
        originRequestOptions.synchronous = YES;
        originRequestOptions.resizeMode = PHImageRequestOptionsResizeModeExact;
        originRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        //sync requests are automatically processed this way regardless of the specified mode
        //originRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        
        originRequestOptions.progressHandler = ^(double progress, NSError *__nullable error, BOOL *stop, NSDictionary *__nullable info){
            dispatch_main_async_safe(^{
                
            });
        };
        [[PHImageManager defaultManager] requestImageForAsset:self targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeDefault options:originRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    Block_exe(resultHandler, result, info);
                });
            }
        }];
    });
}
//TODO:优化从icloud下载的体验
/*need adapt icloud phoho,so need dowanload photo*/
- (void)requestImageForTargetSize:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = CGSizeMake(targetSize.width * scale, targetSize.height * scale);
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.synchronous = YES;
        option.resizeMode = PHImageRequestOptionsResizeModeExact;
        option.version = PHImageRequestOptionsVersionCurrent;
        option.networkAccessAllowed = YES;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
        
        option.progressHandler = ^(double progress, NSError *__nullable error, BOOL *stop, NSDictionary *__nullable info){
            dispatch_main_async_safe(^{
                
            });
        };
        
        [[PHImageManager defaultManager] requestImageForAsset:self targetSize:size contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if (result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    Block_exe(resultHandler, result, info);
                });
            }
        }];
    });
}

- (void)originalSize:(void(^)(NSString *result))result {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
        option.resizeMode = PHImageRequestOptionsResizeModeNone;
        option.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        option.version = PHImageRequestOptionsVersionOriginal;
        option.synchronous = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset:self options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
            
            unsigned long size = imageData.length / 1024;
            NSString *sizeString = [NSString stringWithFormat:@"%liK", size];
            if (size > 1024) {
                NSInteger integral = size / 1024.0;
                NSInteger decimal = size % 1024;
                NSString *decimalString = [NSString stringWithFormat:@"%li",decimal];
                if(decimal > 100){ //取两位
                    decimalString = [decimalString substringToIndex:2];
                }
                sizeString = [NSString stringWithFormat:@"%li.%@M", integral, decimalString];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                Block_exe(result, sizeString);
            });
        }];
    });
}

@end

