//
//  LLImageSelectHandler.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/17.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <Foundation/Foundation.h>

// 选中图片更新通知
static NSString *const kSelectAssetsUpdateNotification = @"kSelectAssetsUpdateNotification";

@interface LLImageSelectHandler : NSObject

+ (instancetype)instance;

@property (nonatomic, assign) BOOL needOriginal;

- (NSArray *)selectedAssets;

- (void)addAsset:(id)asset;

- (void)removeAsset:(id)asset;

- (void)removeAllAssets;

- (BOOL)containsAsset:(id)asset;

- (NSInteger)maxSelectedCount;

- (void)setMaxSelectedCount:(NSInteger)maxSelectedCount;

@end
