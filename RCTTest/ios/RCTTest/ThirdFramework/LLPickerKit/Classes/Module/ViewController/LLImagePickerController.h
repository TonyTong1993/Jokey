//
//  LLImagePickerController.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;
@class PHAsset;

typedef void (^ALAssetsBlock) (NSArray <UIImage *>*imageArray, NSArray <ALAsset *>*assetsArray);
typedef void (^PHAssetsBlock) (NSArray <UIImage *>*imageArray, NSArray <PHAsset *>*assetsArray);

@interface LLImagePickerController : UINavigationController

/** init methods
 * @param max: max selected photos count
 */
- (instancetype)init;
- (instancetype)initWithMaxSelectedCount:(NSInteger)max;

/**
 * @brief maxSelectedCount: max selected photos count
 */
@property (nonatomic, assign) NSInteger maxSelectedCount;

/**
 * @brief autoJumpToPhotoSelectPage: auto push to LLImageCollectionController
 */
@property (nonatomic, assign) BOOL autoJumpToPhotoSelectPage;

/**
 * @brief allowSelectReturnType: 是否允许选择返回图片的样式，在图片展示页面的原图按钮是否显示
 */
@property (nonatomic, assign) BOOL allowSelectReturnType;

/**
 * @brief block, readonly
 */
@property (nonatomic, copy, readonly) ALAssetsBlock alAssetsBlock;

@property (nonatomic, copy, readonly) PHAssetsBlock phAssetsBlock;

/** 获取选择图片数组(ALAsset, iOS8以前)
 * @param block: 回调
 */
- (void)getSelectedALAssetsWithBlock:(ALAssetsBlock)block;

/** 获取选择图片数组(PHAsset, iOS8以后)
 * @param block: 回调
 */
- (void)getSelectedPHAssetsWithBlock:(PHAssetsBlock)block;

@end
