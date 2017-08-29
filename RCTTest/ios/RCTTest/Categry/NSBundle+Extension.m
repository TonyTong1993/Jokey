//
//  NSBundle+Extension.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/29.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "NSBundle+Extension.h"

@implementation NSBundle (Extension)
+(id)loadJsonFromBundle:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSError *error;
   id json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSAssert(!error, [error localizedDescription]);
    return json;
}
@end
