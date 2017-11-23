//
//  LLImageCollectionCell.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ALAsset;
@class PHAsset;

typedef void (^LLImageCollectionCellBlock) (NSInteger index);

@interface LLImageCollectionCell : UICollectionViewCell

- (void)reloadDataWithALAsset:(ALAsset *)asset index:(NSInteger)index;

- (void)reloadDataWithPHAsset:(PHAsset *)asset index:(NSInteger)index;

- (void)resetSelected:(BOOL)selected;

- (void)getSelectedIndexWithBlock:(LLImageCollectionCellBlock)block;

@end
