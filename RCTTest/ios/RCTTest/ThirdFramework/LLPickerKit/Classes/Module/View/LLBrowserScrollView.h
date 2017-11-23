//
//  LLBrowerScrollView.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/17.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLBrowserScrollView : UIScrollView

@property (nonatomic, strong) UIImage *image;

- (void)handleSingleTapActionWithBlock:(dispatch_block_t)block;

- (void)handleDoubleTapActionWithBlock:(dispatch_block_t)block;

- (void)handleLongTapActionWithBlock:(dispatch_block_t)block;
@end
