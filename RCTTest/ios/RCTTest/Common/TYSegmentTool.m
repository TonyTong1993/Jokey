//
//  TYSegmentTool.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYSegmentTool.h"
#import "TYSegmentConst.h"
#import "TYCalculateFrameTool.h"
@implementation TYSegmentTool
+(CGSize)caculateTitlesDefaultFrameWithTitles:(NSArray<NSString *> *)titles {
    return [TYSegmentTool caculateTitlesDefaultFrameWithTitles:titles withFont:[UIFont systemFontOfSize:16]];
}
+(CGSize)caculateTitlesDefaultFrameWithTitles:(NSArray<NSString *> *)titles withFont:(UIFont *)font{
    CGFloat width = segmentPadding*2;
    CGFloat height = segmentPadding*2;
    
    for (NSString *title in titles) {
       CGSize size = [TYCalculateFrameTool frameWithContent:title font:font preferredMaxLayoutWidth:MAXFLOAT];
        
        if (title == [titles lastObject]) {
            width += size.width;
            height += size.height;
        }else {
            width += size.width + segmentMargin;
        }
    }
    return CGSizeMake(width, height);
}
+(CGSize)caculateTitleFrameWithTitle:(NSString *)title withFont:(UIFont *)font {
    
    return [TYCalculateFrameTool frameWithContent:title font:font preferredMaxLayoutWidth:MAXFLOAT];
}
@end
