//
//  TYStatusCommentView.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/23.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYStatusCommentView.h"
@interface TYStatusCommentView()
@property (nonatomic,retain) UIImageView *bgView;
@property (nonatomic,retain) UIButton *upBtn;
@property (nonatomic,retain) UIButton *downBtn;
@property (nonatomic,retain) UILabel *countLabel;
@end
@implementation TYStatusCommentView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [UIImage imageNamed:@"bg_best_reply_150x62_"];
        _upBtn = [[UIButton alloc] init];
        [_upBtn setImage:[UIImage imageNamed:@"best_reply_like_12x12_"] forState:UIControlStateNormal];
        _downBtn = [[UIButton alloc] init];
         [_downBtn setImage:[UIImage imageNamed:@"best_reply_hate_12x12_"] forState:UIControlStateNormal];
        _countLabel = [[UILabel alloc] init];
        _countLabel.font = [UIFont fontWithName:[TYTheme themeFontFamilyName] size:11];
        _countLabel.textColor = HEXCOLOR(themeColorHexValue);
        _countLabel.text = @"2048";
        [self addSubview:_bgView];
        [self addSubview:_upBtn];
        [self addSubview:_downBtn];
        [self addSubview:_countLabel];
        
    }
    return self;
}

-(void)layoutSubviews {
    __weak typeof(self) weakSelf = self;
    [_bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.left.mas_equalTo(weakSelf.mas_left).offset(12);
        make.bottom.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf.mas_right).offset(-12);
    }];
    [_downBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-32);
        make.top.mas_equalTo(10);
    }];
    [_countLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.downBtn.mas_centerY);
        make.right.mas_equalTo(weakSelf.downBtn.mas_left).offset(-8);
    }];
    [_upBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.countLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.countLabel.mas_left).offset(-8);
    }];
}

@end
