//
//  TYTitleView.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/17.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYTitleView.h"
#define padding 10
#define margin  20
@implementation TYTitleView

-(instancetype)initWithTitles:(NSArray *)titles withFont:(UIFont *)font{
    self = [super init];
    if (self) {
        _titles = titles;
        _font = font;
        //计算titleView尺寸
        
        [self setContent];
    }
    return self;
}
-(void)setTitles:(NSArray *)titles withFont:(UIFont *)font withTextNormalColor:(UIColor *)normalColor withTextSelectedColor:(UIColor *)selectedColor{
    _titles = titles;
    _font = font;
    _textNormalColor = normalColor;
    _textSelectedColor = selectedColor;
    //计算titleView尺寸
    [self setContent];
}
-(void)layoutSubviews {
    [super layoutSubviews];
    
    
}
-(void)calculateTitleViewFrame {
    CGFloat width;
    CGFloat height;
    NSMutableArray *mtarray = [[NSMutableArray alloc] init];
    for (NSString *title in _titles) {
      CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_font} context:nil].size;
        CGFloat itemW = size.width;
        CGFloat itemH = size.height;
        height = itemH + padding * 2;
        width = itemW + padding * 2;
//        NSDictionary *dict = @{@"title":title,@"width":@"",@"height"};
    }
}
-(void)setContent {
    
}
@end
