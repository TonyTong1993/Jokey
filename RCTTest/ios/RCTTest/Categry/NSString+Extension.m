//
//  NSString+Extension.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/14.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
+(NSString *)nameSpaceWrapedClassNameInSwift:(NSString *)className {
    return [NSString stringWithFormat:@"%@.%@",[NSBundle mainBundle].infoDictionary[@"CFBundleExecutable"],className];
}
@end
