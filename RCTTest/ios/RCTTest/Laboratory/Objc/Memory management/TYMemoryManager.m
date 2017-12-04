//
//  TYMemoryManager.m
//  RCTTest
//
//  Created by 童万华 on 2017/11/29.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYMemoryManager.h"
#import "TYImageTest.h"
@implementation TYMemoryManager
-(instancetype)init {
    self =  [super init];
    if (self) {
        TYImageTest *allocObj = [[TYImageTest alloc] init];
        NSLog(@"allocObj retainCount = %lu",[allocObj retainCount]);
        
        TYImageTest *newObj = [[TYImageTest alloc] init];
        NSLog(@"newObj retainCount = %lu",[newObj retainCount]);
        
        TYImageTest *retainObj = [allocObj retain];
        NSLog(@"retainObj retainCount = %lu",[retainObj retainCount]);
        NSLog(@"allocObj  retainCount = %lu",[allocObj retainCount]);
        
        TYImageTest *copyObj = [newObj copy];
        NSLog(@"copyObj retainCount = %lu",[copyObj retainCount]);
        NSLog(@"newObj retainCount = %lu",[newObj retainCount]);
        
       
    }
    return self;
}

@end
