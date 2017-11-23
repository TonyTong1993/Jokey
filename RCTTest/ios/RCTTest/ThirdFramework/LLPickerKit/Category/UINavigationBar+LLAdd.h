//
//  UINavigationBar+LLAdd.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (LLAdd)

/**
 * @param color: 背景色
 */
- (void)ll_setBackgroundColor:(UIColor *)color;

/**
 * 设置navigationBar为微信样式(渐变色加透明度)
 */
- (void)ll_setWeiXinStyle;

/**
 * 移除navigationBar底部的横线
 */
- (void)ll_removeUnderline;

@end
