//
//  TYPhotoHandler.h
//  RCTTest
//
//  Created by 童万华 on 2017/11/23.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "PHAsset+Image.h"
/*
    1.获取当前授权状态
    2.查询相册
    3.从相册中获取缩略图片
    4.获取原始图片
 */
// 访问相册授权状态
typedef NS_ENUM(NSInteger, TYAuthorizationStatus) {
    // 未确定授权
    TYAuthorizationStatusNotDetermined = 0,
    // 限制授权
    TYAuthorizationStatusRestricted,
    // 拒绝授权
    TYAuthorizationStatusDenied,
    // 已授权
    TYAuthorizationStatusAuthorized,
};

@interface TYPhotoHandler : NSObject
+ (TYAuthorizationStatus)authorizationStatus;
+ (void)requestAuthorization:(void(^)(TYAuthorizationStatus status))handler;
@end

@interface TYPhotoHandler(PHAssets)
+(void)enumeratePHAssetCollectionsWithResultHandler:(void(^)(NSArray <PHAssetCollection *>*result))resultHandler;
+ (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)collection finishBlock:(void(^)(NSArray <PHAsset *>*result))finishBlock ;
+(void)enumerateAllAssetsInCollectionsWithfinishBlock:(void(^)(PHFetchResult <PHAsset *>*result))finishBlock;
@end

@interface TYPhotoHandler(ALAssets)

@end

@interface PHAssetCollection (LLAdd)
- (NSInteger)numberOfAssets;

@end
