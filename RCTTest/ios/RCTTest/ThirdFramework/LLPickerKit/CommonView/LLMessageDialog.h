//
//  LLMessageDialog.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLMessageDialog : NSObject

// 黑底白字
+ (void)showMessageDialog:(NSString *)msg;

// 白底黑字
+ (void)showMessageDialogWithBlackText:(NSString *)msg;

@end
