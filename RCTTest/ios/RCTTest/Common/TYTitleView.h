//
//  TYTitleView.h
//  RCTTest
//
//  Created by 童万华 on 2017/7/17.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYTitleView : UIView

@property (nonatomic,copy) NSArray *titles;
@property (nonatomic,retain) UIView *scrollLine;//滚动条
@property (strong, nonatomic) UIColor *textNormalColor;//字体颜色
@property (strong, nonatomic) UIColor *textSelectedColor;//字体颜色
@property (strong, nonatomic) UIFont *font;
@property (assign, nonatomic, getter=isSelected) BOOL selected;

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;
@end
