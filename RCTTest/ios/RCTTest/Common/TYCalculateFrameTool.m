//
//  TYCalculateFrameTool.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYCalculateFrameTool.h"

@implementation TYCalculateFrameTool
+(CGSize)frameWithContent:(NSString *)content font:(UIFont *)font preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth{
   
    return  [content boundingRectWithSize:CGSizeMake(preferredMaxLayoutWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
}
@end
