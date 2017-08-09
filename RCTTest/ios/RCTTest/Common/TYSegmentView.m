//
//  TYSegmentView.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYSegmentView.h"
#import "UIButton+TYExtension.h"
#import "UIColor+RGBA.h"
#import "TYSegmentTool.h"
#import "TYSegementIndicatorView.h"
#define indicatorViewHeight 2
@interface TYSegmentView ()
@property (nonatomic,copy) NSArray *titles;

@property (nonatomic,copy) NSArray *items;

@property (nonatomic,weak) NSArray *normalColorRgbaArr;

@property (nonatomic,weak) NSArray *selectedColorRgbaArr;

@property (nonatomic,weak) NSArray *gradientRgbaArr;

@property (nonatomic,weak) UIButton *oldsSelectedItem;

@property (nonatomic,weak) UIButton *newsSelectedItem;

@property (nonatomic,strong) TYSegementIndicatorView *indicatorView;

-(void)setTitleNormalColor:(UIColor *)normalColor item:(UIButton *)item;
-(void)setTitleSelectedColor:(UIColor *)selectedColor item:(UIButton *)item;
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
- (NSArray *)normalColorRgbaArr
{
    if (!_normalColorRgbaArr) {
        NSArray *normalColorRgbaArr = [UIColor colorForRGBAWithConvertColor:_titleNormalColor];
        _normalColorRgbaArr = normalColorRgbaArr;
    }
    return  _normalColorRgbaArr;
}
- (NSArray *)selectedColorRgbaArr
{
    if (!_selectedColorRgbaArr) {
        NSArray *selectedColorRgbaArr = [UIColor colorForRGBAWithConvertColor:_titleSelectedColor];
        _selectedColorRgbaArr = selectedColorRgbaArr;
    }
    return  _selectedColorRgbaArr;
}
- (NSArray *)gradientRgbaArr
{
    if (!_gradientRgbaArr) {
        NSArray *gradientRgbaArr = [UIColor colorForGradientRGBAWith:self.normalColorRgbaArr selectedRgbaComponents:self.selectedColorRgbaArr];
        _gradientRgbaArr= gradientRgbaArr;
    }
    return  _gradientRgbaArr;
}
-(void)setSelectedItemIndex:(NSUInteger)selectedItemIndex {
    _selectedItemIndex = selectedItemIndex;
    
}
-(void)updateSelectedItemIndex:(NSUInteger)selectedItemIndex {
    if (selectedItemIndex != _selectedItemIndex) {
        UIButton *preItem = _items[_selectedItemIndex];
        UIButton *lastItem = _items[selectedItemIndex];
        [preItem setSelected:false];
        [lastItem setSelected:true];
        _selectedItemIndex = selectedItemIndex;
       
    }
    [_items enumerateObjectsUsingBlock:^(UIButton*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       [self setTitleNormalColor:_titleNormalColor item:obj];
       [self setTitleSelectedColor:_titleSelectedColor item:obj];
    }];
}
-(void)setIndicatorBackgroundColor:(UIColor *)color {
    self.indicatorView.backgroundColor = color;
}
-(void)setIndicatorViewScrollOffSetX:(UIScrollView *)scrollView {
    NSUInteger count = self.titles.count;
    CGFloat value = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (value >= count - 1) return;
    if (value <= 0) return;
    CGFloat scaleRight = 0;
    CGFloat scaleLeft = 0;
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    scaleRight = value - leftIndex;
    scaleLeft  = 1 - scaleRight;
    if (scaleLeft == 1 && scaleRight == 0)return;
    UIButton * leftItem = self.items[leftIndex];
    UIButton * rightItem;
    if (rightIndex < count) {
         rightItem = self.items[rightIndex];
    }
    CGFloat originalY =  _indicatorView.center.y;
    CGFloat centerX = leftItem.center.x + (rightItem.center.x - leftItem.center.x) * scaleRight;
    _indicatorView.center = CGPointMake(centerX, originalY);
    [self setupGramientWithValueTag:value leftItem:leftItem rightItem:rightItem scaleRight:scaleRight];
    
}
-(void)setupGramientWithValueTag:(NSInteger)value leftItem:(UIButton*)leftItem rightItem:(UIButton*)rightItem scaleRight:(CGFloat)scaleRight
{
    if (value > _selectedItemIndex || value == _selectedItemIndex) {
        [self setTitleSelectedColor:[UIColor oldColorWithSelectedColorRGBA:self.selectedColorRgbaArr deltaRGBA:self.gradientRgbaArr scale:scaleRight] item:leftItem];
         _oldsSelectedItem =  leftItem;
         [self setTitleNormalColor:[UIColor newColorWithNormalColorRGBA:self.normalColorRgbaArr deltaRGBA:self.gradientRgbaArr scale:scaleRight] item:rightItem];
         _newsSelectedItem = rightItem;
    }else{
        
        [self setTitleNormalColor:[UIColor oldColorWithSelectedColorRGBA:self.selectedColorRgbaArr deltaRGBA:self.gradientRgbaArr scale:scaleRight] item:leftItem];
         _newsSelectedItem = leftItem;
        [self setTitleSelectedColor:[UIColor newColorWithNormalColorRGBA:self.normalColorRgbaArr deltaRGBA:self.gradientRgbaArr scale:scaleRight] item:rightItem];
         _oldsSelectedItem =  rightItem;
    }
}
- (void)segment_resetItemTextNormalColors
{
    [self setTitleNormalColor:_titleNormalColor item:_oldsSelectedItem];
}

-(void)setTitleNormalColor:(UIColor *)normalColor item:(UIButton *)item{
    [item setTitleColor:normalColor forState:UIControlStateNormal];
}
-(void)setTitleSelectedColor:(UIColor *)selectedColor item:(UIButton *)item{
     [item setTitleColor:selectedColor forState:UIControlStateSelected];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemW = self.frame.size.width/self.titles.count;
    CGFloat itemH = self.frame.size.height;
    
    
    NSArray *items = [UIButton buttonWithTitles:self.titles normalColor:self.titleNormalColor selectedColor:self.titleSelectedColor font:self.titleFont frame:CGRectMake(0, 0, itemW, itemH)];
    self.items = items;
    __weak typeof(self) weakSelf = self;
    [items enumerateObjectsUsingBlock:^(UIButton *item, NSUInteger idx, BOOL * _Nonnull stop) {
        item.mj_origin = CGPointMake(itemW*idx, 0);
        [item addTarget:self action:@selector(handleItemSelectedAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        
        if (item.indexInSegmentView == weakSelf.selectedItemIndex) {
            [item setSelected:YES];
            
            //更新指示器
            NSString *title = weakSelf.titles[idx];
            
            [self updateIndicatorViewWithTitle:title animated:false];
            
        }
    }];
    
}

-(void)handleItemSelectedAtIndex:(UIButton *)selectedItem {
    if (selectedItem.indexInSegmentView != self.selectedItemIndex) {
        UIButton *currentSeletedItem = _items[_selectedItemIndex];
        [currentSeletedItem setSelected:false];
        [selectedItem setSelected:YES];
        _selectedItemIndex = selectedItem.indexInSegmentView;
        //更新指示器
        NSString *title = _titles[_selectedItemIndex];
        [self updateIndicatorViewWithTitle:title animated:true];
        
        if (_delegate &&[_delegate respondsToSelector:@selector(segmentConrol:didSelectedItemAtIndex:)]) {
            [_delegate segmentConrol:self didSelectedItemAtIndex:selectedItem.indexInSegmentView];
        }
    }
    
}
-(void)updateIndicatorViewWithTitle:(NSString *)title animated:(BOOL)animated{
    CGSize size = [TYSegmentTool caculateTitleFrameWithTitle:title withFont:self.titleFont];
    UIButton *currentSeletedItem = _items[_selectedItemIndex];
    CGFloat itemW = currentSeletedItem.frame.size.width;
    CGFloat itemH = currentSeletedItem.frame.size.height;
    CGFloat itemOX = currentSeletedItem.frame.origin.x;
    CGFloat startX = itemOX + (itemW -size.width)/2;
    
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.frame = CGRectMake(startX, itemH-2, size.width, indicatorViewHeight);
        }];
    }else {
         self.indicatorView.frame = CGRectMake(startX, itemH-2, size.width, indicatorViewHeight);
    }
    
}

-(void)updateIndicatorViewWithTitle:(NSString *)title {
    CGSize size = [TYSegmentTool caculateTitleFrameWithTitle:title withFont:self.titleFont];
    UIButton *currentSeletedItem = _items[_selectedItemIndex];
    CGFloat itemW = currentSeletedItem.frame.size.width;
    CGFloat itemH = currentSeletedItem.frame.size.height;
    CGFloat itemOX = currentSeletedItem.frame.origin.x;
    CGFloat startX = itemOX + (itemW -size.width)/2;
    self.indicatorView.frame = CGRectMake(startX, itemH-2, size.width, indicatorViewHeight);
}
@end
