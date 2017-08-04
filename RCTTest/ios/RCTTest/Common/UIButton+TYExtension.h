//
//  UIButton+TYExtension.h
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (TYExtension)
@property (nonatomic,assign) NSUInteger indexInSegmentView;
+(NSArray <UIButton *>*)buttonWithTitles:(NSArray <NSString *> *)titles normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selecteColor font:(UIFont *)font frame:(CGRect)frame;
@end
