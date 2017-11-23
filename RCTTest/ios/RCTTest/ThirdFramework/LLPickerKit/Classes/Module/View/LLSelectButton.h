//
//  LLSelectButton.h
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLSelectButton;

typedef void (^LLSelectBlock) (LLSelectButton *sender, BOOL isSelected);

@interface LLSelectButton : UIButton

+ (instancetype)building;

- (void)handleSelectButtonEventWithBlock:(LLSelectBlock)block ;

@end
