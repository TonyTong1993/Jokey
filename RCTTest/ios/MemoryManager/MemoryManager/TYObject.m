//
//  TYObject.m
//  MemoryManager
//
//  Created by 童万华 on 2017/11/30.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYObject.h"

@implementation TYObject
-(id)copyWithZone:(NSZone *)zone{
    return [[[self class] alloc] init];
}

@end
