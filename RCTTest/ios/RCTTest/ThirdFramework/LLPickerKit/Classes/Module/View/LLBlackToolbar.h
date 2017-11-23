//
//  LLBlackToolbar.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLToolbar.h"

typedef void (^LLOriginalBlock) (BOOL originalSize);

@interface LLBlackToolbar : LLToolbar

//- (void)returnOriginalImage:(BOOL)original;
- (void)resetSelected:(BOOL)selected;

- (void)originalWithSize:(float)size;

- (void)handleOriginalButtonActionWithBlock:(LLOriginalBlock)block;

@end
//
//@interface LLOriginalButton : UIView
//
//- (instancetype)building;
//
//
//@end
