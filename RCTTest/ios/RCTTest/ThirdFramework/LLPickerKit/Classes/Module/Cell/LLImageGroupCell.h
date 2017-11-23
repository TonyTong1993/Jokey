//
//  LLImageGroupCell.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PHAssetCollection;
@class ALAssetsGroup;

@interface LLImageGroupCell : UITableViewCell

+ (CGFloat)height;

- (void)reloadDataWithAssetsGroup:(ALAssetsGroup *)assetsGroup;

- (void)reloadDataWithAssetCollection:(PHAssetCollection *)assetCollection;

@end
