//
//  LLBlackToolbar.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/22.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLBlackToolbar.h"
#import "Config.h"

@interface LLBlackToolbar ()

@property (nonatomic, strong) UIButton *originalButton;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CAShapeLayer *greenLayer;
//@property (nonatomic, strong) UIButton *originalSizeButton;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, copy) LLOriginalBlock originalBlock;

@end

@implementation LLBlackToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self hiddenPreviewButton];
        self.barStyle = UIBarStyleBlack;
        
        self.originalButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalButton.frame = CGRectMake(0, 0, 150, self.height);
        [_originalButton setTitle:@"原图" forState:UIControlStateNormal];
        [_originalButton addTarget:self action:@selector(handleSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
        _originalButton.titleLabel.textAlignment = 0;
        [self addSubview:_originalButton];
        
        
        [self.layer addSublayer:self.circleLayer];
        [self resetSelected:NO];
    }
    return self;
}

- (void)handleSelectedAction:(UIButton *)sender {
    self.selected = !_selected;
    Block_exe(self.originalBlock, _selected);    
}

- (void)originalWithSize:(float)size {
    self.selected = YES;
}

- (void)handleOriginalButtonActionWithBlock:(LLOriginalBlock)block {
    self.originalBlock = block;
}

- (void)resetSelected:(BOOL)selected {
    self.selected = NO;
    if (selected) {
        [self.circleLayer addSublayer:self.greenLayer];
    } else {
        [self.greenLayer removeFromSuperlayer];
    }
}

- (CAShapeLayer *)circleLayer {
    if (!_circleLayer) {
        CGFloat const centerX = 40.f;
        CGFloat const centerY = self.height / 2;
        CGFloat const radius = 20.f;

        _circleLayer = [CAShapeLayer layer];
        _circleLayer.frame = CGRectMake(centerX - radius, centerY - radius, radius * 2, radius * 2);
        _circleLayer.masksToBounds = YES;
        _circleLayer.cornerRadius = radius;
        _circleLayer.borderWidth = 2.f;
        _circleLayer.borderColor = HEXCOLOR(0x2c2c27).CGColor;
    }
    return _circleLayer;
}

- (CAShapeLayer *)greenLayer {
    if (!_greenLayer) {
        CGFloat const centerX = 20.f;
        CGFloat const centerY = self.height / 2;
        CGFloat const radius = 14.f;
        
        _greenLayer = [CAShapeLayer layer];
        _greenLayer.frame = CGRectMake(centerX - radius, centerY - radius, radius * 2, radius * 2);
        _greenLayer.masksToBounds = YES;
        _greenLayer.cornerRadius = radius;
        _greenLayer.backgroundColor = HEXCOLOR(0x09c106).CGColor;
    }
    return _greenLayer;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//@interface LLOriginalButton ()
//
////@property (nonatomic, strong) UIView *
//
//@end
//
//@implementation LLOriginalButton
//
//+ (instancetype)building {
//    LLOriginalButton *button = [[LLOriginalButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    button.layer.cornerRadius = button.width / 2;
//    button.layer.borderWidth = 3.f;
//    button.clipsToBounds = YES;
//    return button;
//}
//
//@end
