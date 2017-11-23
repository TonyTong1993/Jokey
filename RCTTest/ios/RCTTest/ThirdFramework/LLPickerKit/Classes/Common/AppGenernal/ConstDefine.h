//
//  ConstDefine.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//


#ifndef kScreenWidth
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef kScreenHeight
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

#ifndef LLAppDelegate
#define LLAppDelegate [[UIApplication sharedApplication] delegate]
#endif


/**
 * @brief return const UIColor
 */
#define kPlaceholderImageColor [UIColor groupTableViewBackgroundColor]

#pragma mark - 
#pragma mark - notification name const
static NSString *const kPushToCollectionPageNotification = @"kPushToCollectionPageNotification";

#pragma mark -
#pragma mark - const text  
static NSString *const kPhotosNumberReachedMaxValue = @"您选择的图片数量已达到上限";
