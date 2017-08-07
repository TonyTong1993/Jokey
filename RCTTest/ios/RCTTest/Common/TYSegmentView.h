//
//  TYSegmentView.h
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYSegmentControlDelegate.h"
typedef NS_ENUM(NSUInteger,SegmentControlState) {
    SegmentControlStateNormal = 1,
    SegmentControlStateSelected
};


@interface TYSegmentView : UIView

@property (nonatomic,weak) id <TYSegmentControlDelegate> delegate;

@property (nonatomic,strong,readonly) UIColor *titleNormalColor;

@property (nonatomic,strong,readonly) UIColor *titleSelectedColor;

@property (nonatomic,strong,readonly) UIFont *titleFont;

@property (nonatomic,assign,readonly) NSUInteger selectedItemIndex;

-(instancetype)initWithTitles:(NSArray <NSString *>*)titles;

-(void)setTitleFont:(UIFont *)font;

-(void)setTitleColor:(UIColor *)color state:(SegmentControlState)state;

-(void)setSelectedItemIndex:(NSUInteger)selectedItemIndex;

-(void)setIndicatorBackgroundColor:(UIColor *)color ;

-(void)setIndicatorViewScrollOffSetX:(UIScrollView *)scrollView ;

-(void)updateSelectedItemIndex:(NSUInteger)selectedItemIndex;

- (void)segment_resetItemTextNormalColors;
@end
