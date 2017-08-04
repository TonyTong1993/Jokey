//
//  TYCalculateFrameTool.h
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYCalculateFrameTool : NSObject
+(CGSize)frameWithContent:(NSString *)content font:(UIFont *)font preferredMaxLayoutWidth:(CGFloat)preferredMaxLayoutWidth;
@end
