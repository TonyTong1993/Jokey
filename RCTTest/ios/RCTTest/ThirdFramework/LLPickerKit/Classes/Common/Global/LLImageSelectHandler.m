//
//  LLImageSelectHandler.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/17.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLImageSelectHandler.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

static NSInteger const defaultMaxSelectedCount = 9;

@interface LLImageSelectHandler ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger maxSelectCount;
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

@end

@implementation LLImageSelectHandler

+ (instancetype)instance {
    static LLImageSelectHandler *selectHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        selectHandler = [[LLImageSelectHandler alloc] init];
        selectHandler.dataArray = [NSMutableArray array];
        selectHandler.maxSelectCount = defaultMaxSelectedCount;
        selectHandler.concurrentQueue = dispatch_queue_create("com.concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
        selectHandler.needOriginal = NO;
    });
    return selectHandler;
}

- (NSArray *)selectedAssets {
    __block NSArray *assets;
    dispatch_sync(self.concurrentQueue, ^{
        assets = [NSArray arrayWithArray:_dataArray];
    });
    return assets;
}

- (void)addAsset:(id)asset {
    if (!asset) {
        return;
    }
    dispatch_barrier_async(self.concurrentQueue, ^{
        [_dataArray addObject:asset];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self postSelectAssetsUpdateNotification];
        });
    });
}

- (void)removeAsset:(id)asset {
    if (!asset) {
        return;
    }
    if (![_dataArray containsObject:asset]) {
        return;
    }
    dispatch_barrier_async(self.concurrentQueue, ^{
        [_dataArray removeObject:asset];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self postSelectAssetsUpdateNotification];
        });
    });
}

- (void)removeAllAssets {
    dispatch_barrier_async(self.concurrentQueue, ^{
        [_dataArray removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self postSelectAssetsUpdateNotification];
        });
    });
}

- (BOOL)containsAsset:(id)asset {
    if (!asset || (![asset isKindOfClass:[PHAsset class]] && ![asset isKindOfClass:[ALAsset class]])) {
        return NO;
    }
    return [[self selectedAssets] containsObject:asset];
}

- (void)postSelectAssetsUpdateNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:kSelectAssetsUpdateNotification object:nil];
}

- (NSInteger)maxSelectedCount {
    return self.maxSelectCount;
}

- (void)setMaxSelectedCount:(NSInteger)maxSelectedCount {
    self.maxSelectCount = maxSelectedCount;
}

@end
