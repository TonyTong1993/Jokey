//
//  TYMemoryManager.h
//  RCTTest
//
//  Created by 童万华 on 2017/11/29.
//  Copyright © 2017年 童万华. All rights reserved.
//
/*
 MRC:人工去管理引用计数，
 retainCount:引用计数，相当于是对一块内存区域的所有权的统计，
 alloc:引用计数加1，表示为对象分配内存空间，此时对象的引用计数就会增加，当有另外的对象或指针也指向这块区域时，这块内存的所有权就变成2，当发生指向这块内存区域的对象或指针减到0时，系统会自动销毁掉这块内存
 retain:引用计数加1，
 release:引用计数减1
 copy:引用计数加1
 alloc/new/copy/mutablecopy 以外的方法生成的对象，自己就不是持有者了
 ARC:
 autoRelease:
 autoreleasepool:

 内存管理关键字
 assign:
 strong(ARC):
 retain:
 copy:
 
 */
#import <Foundation/Foundation.h>

@interface TYMemoryManager : NSObject

@end
