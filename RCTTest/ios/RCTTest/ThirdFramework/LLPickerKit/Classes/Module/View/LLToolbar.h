//
//  LLToolbar.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LLToolbarBlock) ();

@interface LLToolbar : UIToolbar

// reset UI style
- (void)resetPreviewButtonEnable:(BOOL)enable;

- (void)resetFinishedButtonEnable:(BOOL)enable;

- (void)resetSelectPhotosNumber:(NSInteger)number;

// handle click callback
- (void)handlePreviewButtonWithBlock:(LLToolbarBlock)block;

- (void)handleFinishedButtonWithBlock:(LLToolbarBlock)block;

// hidden preview button
- (void)hiddenPreviewButton;

@end
