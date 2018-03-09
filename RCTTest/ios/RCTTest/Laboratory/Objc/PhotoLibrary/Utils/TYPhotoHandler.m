//
//  TYPhotoHandler.m
//  RCTTest
//
//  Created by 童万华 on 2017/11/23.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYPhotoHandler.h"
#define iOS8Upwards   [[UIDevice currentDevice].systemVersion floatValue] >= 8.0
@implementation TYPhotoHandler

+(TYAuthorizationStatus)authorizationStatus {
    return iOS8Upwards ? (TYAuthorizationStatus)[ALAssetsLibrary authorizationStatus]:(TYAuthorizationStatus)[PHPhotoLibrary authorizationStatus];
}
+(void)requestAuthorization:(void (^)(TYAuthorizationStatus))handler {
    if (iOS8Upwards) {
        handler((TYAuthorizationStatus)[PHPhotoLibrary authorizationStatus]);
        return;
    }
    handler((TYAuthorizationStatus)[ALAssetsLibrary authorizationStatus]);
}
@end

@implementation TYPhotoHandler(PHAssets)
+(void)enumeratePHAssetCollectionsWithResultHandler:(void(^)(NSArray <PHAssetCollection *>*result))resultHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 照片群组数组
        NSMutableArray *groups = [NSMutableArray array];
        PHFetchResult<PHCollection *> *userAlbums = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
        
        PHFetchResult<PHAssetCollection *> *systemAlbums =  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
       
        [userAlbums enumerateObjectsUsingBlock:^(PHCollection * _Nonnull collection, NSUInteger idx, BOOL * _Nonnull stop) {
                [groups addObject:collection];
        }];
        [systemAlbums enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!([obj.localizedTitle isEqualToString:@"Recently Deleted"] ||
                  [obj.localizedTitle isEqualToString:@"Videos"]||[obj.localizedTitle isEqualToString:@"Hidden"]||[obj.localizedTitle isEqualToString:@"Portrait"])) {
                [groups addObject:obj];
            }
        }];

   
        dispatch_async(dispatch_get_main_queue(), ^{
            resultHandler(groups);
        });
    });
}
+ (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)collection finishBlock:(void(^)(NSArray <PHAsset *>*result))finishBlock {
     NSMutableArray <PHAsset *>*results = [NSMutableArray array];
     PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d",PHAssetMediaTypeImage];
     PHFetchResult <PHAsset *>*assets = [PHAsset fetchAssetsInAssetCollection:collection options:fetchOptions];
    [assets enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [results addObject:obj];
    }];
    finishBlock(results);
}
-(void)enumerateTransientGroupsForGroups {
    
    PHFetchResult<PHCollectionList *> *fetchResultList1 =  [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeMomentList subtype:PHCollectionListSubtypeMomentListCluster options:nil];
    PHFetchResult<PHCollectionList *> *fetchResultList2 =  [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeFolder subtype:PHCollectionListSubtypeRegularFolder options:nil];
    
    PHFetchResult<PHCollectionList *> *fetchResultList3 =  [PHCollectionList fetchCollectionListsWithType:PHCollectionListTypeSmartFolder subtype:PHCollectionListSubtypeSmartFolderEvents options:nil];
    
    [fetchResultList1 enumerateObjectsUsingBlock:^(PHCollectionList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       PHFetchResult<PHCollection *> *collectionResult =  [PHCollection fetchCollectionsInCollectionList:obj options:nil];
        [PHCollectionList transientCollectionListWithCollectionsFetchResult:collectionResult title:nil];
    }];
    
    [fetchResultList2 enumerateObjectsUsingBlock:^(PHCollectionList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
    }];
    
    [fetchResultList3 enumerateObjectsUsingBlock:^(PHCollectionList * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
    }];
}
@end
@implementation TYPhotoHandler(ALAssets)

@end

@implementation PHAssetCollection (LLAdd)
- (NSInteger)numberOfAssets {
    // 注意 %zd 这里不识别，直接导致崩溃
    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:self options:nil];
    return result.count;
}

@end
