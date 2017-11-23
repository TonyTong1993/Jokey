//
//  iPhoneVersion.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#ifndef iPhoneVersion_h
#define iPhoneVersion_h

/**
 * @brief iPhoneVersion
 */
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

/**
 * @brief iOS System Version
 */
#define iOSVersion ([[[UIDevice currentDevice] systemVersion] floatValue]) // iOS系统版本

/**
 * iOS9Upwards 表示 iOS9以上, 则 !iOS9Upwards 表示iOS9以下
 */
// iOS9 以上
#define iOS10Upwards ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
// iOS9 以上
#define iOS9Upwards ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

// iOS8 以上
#define iOS8Upwards ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

// iOS7 以上
#define iOS7Upwards ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)


#endif /* iPhoneVersion_h */
