//
//  main.m
//  MemoryManager
//
//  Created by 童万华 on 2017/11/29.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYObject.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        //内存区块的认识
        /*
         堆：有程序员分配和释放，如果程序员不释放，程序结束时，可能会由操作系统来回收，优点是数据灵活，不必担心大小限制，缺点是容易出现碎片化，管理不当会造成内存泄露，（先进先出FIFO）
         栈：由编译器自动分配并释放，存放函数的参数，局部变量，栈是系统数据结构，对应线程／进程是唯一的。优点是快速高效，缺点是有限制，数据不灵活（先进后出）
         BSS：未初始化的全局变量或静态变量，由系统释放
         常量区：完成初始化的全局变量或静态变量，由系统释放
         代码区：存储二进制程序代码数据
         
         */
        //1.ios中内存管理机制
        /*
             内存管理方法：引用计数
             在xcode中存在两种内存管理环境 ARC和MRC，其中ARC在底层也是使用MRC，只是这部分的工作，从开发者身上转移到xcode编译期中。
             存在的问题，ARC中的对象可能存在不及时释放问题。
             内存管理遵守的原则
             通过alloc、new、copy，mutaleCopy生成的对象，为内存区块的第一持有者，当不再使用时，需主动调用对象的release方法，内存区块的引用计数就会减1；
             通过retain操作，获取的对象或指针，内存区块管理数加1，当不再使用时，使用release，取消对内存区块的持有
         
             1、Objective-C类中实现了引用计数器，对象知道自己当前被引用的次数
         
             2、最初对象的计数器为1
         
             3、如果需要引用对象，可以给对象发送一个retain消息，这样对象的计数器就加1
         
             4、当不需要引用对象了，可以给对象发送release消息，这样对象计数器就减1
         
             5、当计数器减到0，自动调用对象的dealloc函数，对象就会释放内存
         
             6、计数器为0的对象不能再使用release和其他方法
         
         
         */
        
        //2.常见的内存问题
        NSMutableString *name = [[NSMutableString alloc] initWithString:@"tony"];//
        NSMutableString *title = [[NSMutableString alloc] initWithString:@"memory manager"];
        
        TYObject *obj1 = [[TYObject alloc] init];
        obj1.title = title;//测试copy关键字
        obj1.name = name;//测试strong关键字
        NSLog(@"obj1.name retain count = %lu \
              --obj1.title retain count = %lu \
              ---%p------title=%@----name=%@",[obj1.name retainCount],[obj1.title retainCount],obj1,obj1.title,obj1.name);
        [name appendString:@" hello world!"];
        [title appendString:@" hello world!"];
        NSLog(@"--title=%@----name=%@",obj1.title,obj1.name);
        


        
        
//        NSString *staticStr = @"hello world";
//        NSLog(@"staticStr retain count = %lu-----%p----%@",[staticStr retainCount],staticStr,staticStr);
//
//        NSString *copyStr = [staticStr copy];
//        NSLog(@"copyStr retain count = %lu-----%p----%@",[copyStr retainCount],copyStr,copyStr);
//
//        NSString *mcopyStr = [staticStr mutableCopy];
//        NSLog(@"mcopyStr retain count = %lu-----%p----%@",[mcopyStr retainCount],mcopyStr,mcopyStr);
        
      
        //3.内存管理关键字的使用
    }
    return 0;
}
