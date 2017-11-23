//
//  LLImageHandler.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/17.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

// http://kayosite.com/ios-development-and-detail-of-photo-framework.html

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

// 访问相册授权状态
typedef NS_ENUM(NSInteger, LLAuthorizationStatus) {
    // 未确定授权
    LLAuthorizationStatusNotDetermined = 0,
    // 限制授权
    LLAuthorizationStatusRestricted,
    // 拒绝授权
    LLAuthorizationStatusDenied,
    // 已授权
    LLAuthorizationStatusAuthorized,
};

@interface LLImageHandler : NSObject

/** 获取相册授权状态
 * @brief 如果返回值为 LLAuthorizationStatusDenied | LLAuthorizationStatusDenied,
 *        则相册授权不成功, 不应进行下面的动作
 */
+ (LLAuthorizationStatus)requestAuthorization;

+ (void)requestAuthorization:(void(^)(LLAuthorizationStatus status))handler;


#pragma mark -
#pragma mark - 获取所有相册
/** 获取所有相册(iOS8及以下)
 * @brief result 的元素类型为 PHAssetCollection
 */
- (void)enumerateALAssetsGroupsWithResultHandler:(void(^)(NSArray <ALAssetsGroup *>*result))resultHandler NS_DEPRECATED_IOS(4_0, 9_0, "Use the enumeratePHAssetCollectionsWithResultHandler: instead");

/** 获取所有相册(iOS8及以上)
 * @brief result 的元素类型为 PHAssetCollection
 */
- (void)enumeratePHAssetCollectionsWithResultHandler:(void(^)(NSArray <PHAssetCollection *>*result))resultHandler NS_AVAILABLE_IOS(8_0);

/** 获取所有相册(兼容iOS8及iOS8)
 * @brief 如果iOS系统是8.0或以上, 则 result 的元素类型为 PHAssetCollection, 否则为 ALAssetsGroup
 */
- (void)enumerateGroupsWithFinishBlock:(void(^)(NSArray *result))finishBlock;

#pragma mark -
#pragma mark - 获取某一相册下所有图片资源
/** 获取某一相册下所有图片资源(iOS8以下)
 * @param assetsGroup: 相册
 * @param finishBlock: 完成回调
 */
- (void)enumerateAssetsInAssetsGroup:(ALAssetsGroup *)group finishBlock:(void(^)(NSArray <ALAsset *>*result))finishBlock NS_DEPRECATED_IOS(4_0, 9_0, "Use the enumerateAssetsInAssetCollection:usingBlock: instead");

/** 获取某一相册下所有图片资源(iOS8以上)
 * @param assetCollection: 相册
 * @param finishBlock: 完成回调
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)collection finishBlock:(void(^)(NSArray <PHAsset *>*result))finishBlock NS_AVAILABLE_IOS(8_0);

/** 获取某一相册下所有图片资源(兼容iOS8及iOS8)
 * @param group: 相册, 类型只能为PHAssetCollection(iOS8.0及以上)或ALAssetsGroup(iOS8.0以下)
 * @param finishBlock: 完成回调
 */
- (void)enumerateAssetsInGroup:(id)group finishBlock:(void(^)(NSArray *result))finishBlock;

#pragma mark -
#pragma mark -保存图片到相册


@end

@interface PHAssetCollection (LLAdd)

- (void)posterImage:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

- (void)posterImage:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

- (NSInteger)numberOfAssets;

@end

@interface PHAsset (LLAdd)

// 缩略图
- (void)thumbnail:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

- (void)thumbnail:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

// 原图
- (void)original:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

// 目标尺寸视图
- (void)requestImageForTargetSize:(CGSize)targetSize resultHandler:(void(^)(UIImage *result, NSDictionary *info))resultHandler;

- (void)originalSize:(void(^)(NSString *result))result;

@end
