//
//  LCameraViewController.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/23.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Config.h"

typedef void (^CameraBlock) (UIImage *image, NSDictionary *info);

@interface LLCameraViewController : UIImagePickerController

/** 拍摄照片回调方法
 * @brief image: 拍摄获取的图片, info: 图片的相关信息
 */
- (void)getResultFromCameraWithBlock:(CameraBlock)block;

@end
