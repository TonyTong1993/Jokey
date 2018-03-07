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
+(BOOL)isEmptyOrNil:(NSString *)string {
    if([string length] == 0) { //string is empty or nil
        return YES;
    }
    return NO;
}
@end
