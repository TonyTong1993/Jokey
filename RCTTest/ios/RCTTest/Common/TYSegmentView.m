//
//  TYSegmentView.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYSegmentView.h"
#import "UIButton+TYExtension.h"
#import "TYSegmentTool.h"
#import "TYSegementIndicatorView.h"
#define indicatorViewHeight 2
@interface TYSegmentView ()
@property (nonatomic,copy) NSArray *titles;

@property (nonatomic,strong) UIButton *currentSeletedItem;

@property (nonatomic,strong) TYSegementIndicatorView *indicatorView;
@end
@implementation TYSegmentView

-(instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    self = [super init];
    if (self) {
        self.titles = titles;
        
        CGSize defaultSize = [TYSegmentTool caculateTitlesDefaultFrameWithTitles:titles];
        
        self.frame = CGRectMake(0, 0, defaultSize.width, defaultSize.height);
        
        self.indicatorView = [TYSegementIndicatorView indicatorView];
        
        [self addSubview:self.indicatorView];
        //设置默认style
        _titleFont = [UIFont systemFontOfSize:16];
        _titleNormalColor = [UIColor blackColor];
        _titleSelectedColor = [UIColor blueColor];
    }
    
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        CGSize defaultSize = [TYSegmentTool caculateTitlesDefaultFrameWithTitles:titles];
        CGFloat width = defaultSize.width > frame.size.width ? defaultSize.width : frame.size.width;
        CGFloat height = defaultSize.height > frame.size.height ? defaultSize.height : frame.size.height;
        self.frame = CGRectMake(0, 0,width, height);
        
        //设置默认style
        _titleFont = [UIFont systemFontOfSize:16];
        _titleNormalColor = [UIColor blackColor];
        _titleSelectedColor = [UIColor blueColor];
    }
    return self;
}


-(void)setTitleFont:(UIFont *)font {
    _titleFont = font;
    
    CGSize defaultSize = [TYSegmentTool caculateTitlesDefaultFrameWithTitles:_titles withFont:font];
    CGFloat width = defaultSize.width > self.frame.size.width ? defaultSize.width : self.frame.size.width;
    CGFloat height = defaultSize.height > self.frame.size.height ? defaultSize.height : self.frame.size.height;
    
    self.frame = CGRectMake(0, 0,width, height>44?44:height);
}

-(void)setTitleColor:(UIColor *)color state:(SegmentControlState)state {
    switch (state) {
        case SegmentControlStateNormal:
            _titleNormalColor = color;
            break;
        case SegmentControlStateSelected:
            _titleSelectedColor = color;
            break;
    }
}

-(void)setSelectedItemIndex:(NSUInteger)selectedItemIndex {
    _selectedItemIndex = selectedItemIndex;
}

-(void)setIndicatorBackgroundColor:(UIColor *)color {
    self.indicatorView.backgroundColor = color;
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemW = self.frame.size.width/self.titles.count;
    CGFloat itemH = self.frame.size.height;
    
    
    NSArray *items = [UIButton buttonWithTitles:self.titles normalColor:self.titleNormalColor selectedColor:self.titleSelectedColor font:self.titleFont frame:CGRectMake(0, 0, itemW, itemH)];
    
    __weak typeof(self) weakSelf = self;
    [items enumerateObjectsUsingBlock:^(UIButton *item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.mj_origin = CGPointMake(itemW*idx, 0);
        [item addTarget:self action:@selector(handleItemSelectedAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        
        if (item.indexInSegmentView == weakSelf.selectedItemIndex) {
            [item setSelected:YES];
            weakSelf.currentSeletedItem = item;
            
            //更新指示器
            NSString *title = weakSelf.titles[idx];
            
            [self updateIndicatorViewWithTitle:title animated:false];
            
        }
    }];
    
}

-(void)handleItemSelectedAtIndex:(UIButton *)selectedItem {
    if (selectedItem != self.currentSeletedItem) {
        [self.currentSeletedItem setSelected:false];
        [selectedItem setSelected:YES];
        self.currentSeletedItem = selectedItem;
         NSString *title = self.titles[selectedItem.indexInSegmentView];
        [self updateIndicatorViewWithTitle:title animated:true];
        if (_delegate &&[_delegate respondsToSelector:@selector(segmentConrol:didSelectedItemAtIndex:)]) {
            [_delegate segmentConrol:self didSelectedItemAtIndex:selectedItem.indexInSegmentView];
        }
    }
    
}

-(void)updateIndicatorViewWithTitle:(NSString *)title animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self updateIndicatorViewWithTitle:title];
        }];
        
    }else {
        [self updateIndicatorViewWithTitle:title];
    }
}
-(void)updateIndicatorViewWithTitle:(NSString *)title {
    CGSize size = [TYSegmentTool caculateTitleFrameWithTitle:title withFont:self.titleFont];
    CGFloat itemW = self.currentSeletedItem.frame.size.width;
    CGFloat itemH = self.currentSeletedItem.frame.size.height;
    CGFloat itemOX =  self.currentSeletedItem.frame.origin.x;
    CGFloat startX = itemOX + (itemW -size.width)/2;
    self.indicatorView.frame = CGRectMake(startX, itemH-2, size.width, indicatorViewHeight);
}
@end
