//
//  LLImageBrowserController.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/17.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLBaseViewController.h"

@class ALAsset;
@class PHAsset;

@interface LLImageBrowserController : LLBaseViewController

@property (nonatomic, copy) NSArray <ALAsset *>*alAssetsArray;
@property (nonatomic, copy) NSArray <PHAsset *>*phAssetsArray;
@property (nonatomic, assign) NSInteger index;

@end
