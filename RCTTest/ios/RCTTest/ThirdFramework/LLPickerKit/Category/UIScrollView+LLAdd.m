//
//  UIScrollView+LLAdd.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "UIScrollView+LLAdd.h"

@implementation UIScrollView (LLAdd)

- (void)scrollsToBottomAnimated:(BOOL)animated {
    CGFloat offset = self.contentSize.height - self.bounds.size.height + self.contentInset.bottom;
    if (offset > 0) {
        [self setContentOffset:CGPointMake(0, offset) animated:animated];
    }
}

@end
