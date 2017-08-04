//
//  UIButton+TYExtension.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "UIButton+TYExtension.h"
#import <objc/runtime.h>
char KIndexInSegmentView;
@implementation UIButton (TYExtension)
-(NSUInteger)indexInSegmentView {
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, &KIndexInSegmentView);
    return  [number unsignedIntValue];
}

-(void)setIndexInSegmentView:(NSUInteger)indexInSegmentView {
    objc_setAssociatedObject(self, &KIndexInSegmentView, [NSNumber numberWithUnsignedInteger:indexInSegmentView], OBJC_ASSOCIATION_ASSIGN);
}


+(NSArray<UIButton *> *)buttonWithTitles:(NSArray <NSString *> *)titles normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selecteColor font:(UIFont *)font frame:(CGRect)frame{
    NSMutableArray *items = [NSMutableArray array];
    for (NSString *title in titles) {
        UIButton *segmentItem  = [[UIButton alloc] initWithFrame:frame];
        segmentItem.indexInSegmentView = [titles indexOfObject:title];
        [segmentItem setTitle:title forState:UIControlStateNormal];
        [segmentItem setTitleColor:normalColor forState:UIControlStateNormal];
        [segmentItem setTitleColor:selecteColor forState:UIControlStateSelected];
        segmentItem.titleLabel.font = font;
        [items addObject:segmentItem];
    }
    return items;
}
@end
