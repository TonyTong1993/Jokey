//
//  TYPoprosManager.m
//  RCTTest
//
//  Created by 童万华 on 2017/9/7.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYPoprosManager.h"

@implementation TYPoprosManager
+(instancetype)sharePoprosManager{
    static dispatch_once_t onceToken;
    static TYPoprosManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[TYPoprosManager alloc] init];
    });
    return _instance;
}
@end
