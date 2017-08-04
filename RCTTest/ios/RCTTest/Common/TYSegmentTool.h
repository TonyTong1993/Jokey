//
//  TYSegmentTool.h
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYSegmentTool : NSObject
+(CGSize)caculateTitlesDefaultFrameWithTitles:(NSArray <NSString *>*)titles;
+(CGSize)caculateTitlesDefaultFrameWithTitles:(NSArray<NSString *> *)titles withFont:(UIFont *)font;
+(CGSize)caculateTitleFrameWithTitle:(NSString *)title withFont:(UIFont *)font;
@end
