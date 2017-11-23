//
//  LLSelectButton.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLSelectButton.h"
#import "Config.h"

@interface LLSelectButton ()

@property (nonatomic, copy) LLSelectBlock selectBlock;

@end

@implementation LLSelectButton

+ (instancetype)building {
    LLSelectButton *button = [LLSelectButton buttonWithType:UIButtonTypeCustom];
    button.selected = NO;
    button.backgroundColor = [UIColor clearColor];
    return button;
}

- (void)handleSelectButtonEventWithBlock:(LLSelectBlock)block {
    self.selectBlock = block;
    [self addTarget:self action:@selector(handleSelectButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleSelectButtonEvent:(LLSelectButton *)sender {
    self.selected = !self.isSelected;
    Block_exe(_selectBlock, self, self.isSelected);
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self setImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
    } else {
        [self setImage:[UIImage imageNamed:@"unSelect.png"] forState:UIControlStateNormal];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
