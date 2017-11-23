//
//  ALAsset+LLAdd.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/20.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface ALAsset (LLAdd)

- (UIImage *)fullResolutionImage;

- (UIImage *)fullScreenImage;

- (void)originalSize:(void(^)(NSString *result))result;

@end
