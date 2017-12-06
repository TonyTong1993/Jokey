//
//  main.m
//  Muti-Thread
//
//  Created by 童万华 on 2017/12/4.
//  Copyright © 2017年 童万华. All rights reserved.
//
/*
 线程：线程是进程的子单元，操作系统的调度器可以对线程进行单独的调度，实际上，所有的并发编程API都是构建于线程之上的。
 多线程可以在单核CPU上同时运行。操作系统将小的时间片分配给每一个线程，这样就能让用户感觉到多个任务在同时进行。
 如果CPU是多核的话，那么线程就可以真正以并发的方式执行，从而减少了完成某项操作所需要的总时间。(时间共享)
 
 
 pthread:跨平台的操作多线程的C语言API，线程生命周期由程序猿来管理，几乎不使用。
 NSThread:OC语言的API对pthread的封装，线程生命周期由程序猿来管理，很少使用。
 GCD:基于C语言的API，线程生命周期由系统管理，经常使用。面向的是队列和代码块；GCD公开有5个不同的队列：主队列、3个不同优先级的后台队列，以及优先级更低的后台队列。开发者可以自定义队列：串行或者并行队列。自定义队列非常强大，自定义队列中被调度的所有block最终都被放在系统的全局队列中和线程池中。
 NSOpeartionQueue／NSOperation:基于GCD实现的一套OC面向对象的高级封装，增加了许多使用GCD实现复杂的功能。有两种不同的队列：主队列和自定义队列。
 Run Loops
 */
#import <Foundation/Foundation.h>
#import "TestSortModel.h"
void task0() {
    printf("task0 \n");
}
void task1() {
    printf("task1 \n");
}
void task2() {
    printf("task2 \n");
}
void task3() {
    printf("task3 \n");
}
void task4() {
    printf("task4 \n");
}
void syncInMainThreadTask() {//线程死锁模拟
    task0();
    dispatch_sync(dispatch_get_main_queue(), ^{
        task1();
    });
    task2();
    /*
     首先执行任务0，这是肯定没问题的，只是接下来，程序遇到了同步线程，那么它会进入等待，等待任务1执行完，然后执行任务2。但这是队列，有任务来，当然会将任务加到队尾，然后遵循FIFO原则执行任务。那么，现在任务1就会被加到最后，任务2排在了任务1前面，问题来了：
     
     任务2要等任务1执行完才能执行，任务1又排在任务2后面，意味着任务1要在任务2执行完才能执行，所以他们进入了互相等待的局面。【既然这样，那干脆就卡在这里吧】这就是死锁
     
     */
}
void preformSyncTaskInGlobalThread() {
    task0();
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        task1();
    });
    task2();
    /*
     从dispatch_get_global_queue可以看出，任务1被加入到了全局的并行队列中，当并行队列执行完任务1以后，返回到主队列，继续执行任务2
     */
}
void perfromTaskInSerialQueue() {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.lptiyu.cn", DISPATCH_QUEUE_SERIAL);
    task0();
    dispatch_async(serialQueue, ^{
        task1();
        dispatch_sync(dispatch_get_main_queue(), ^{
            task2();
        });
        task3();
    });
    task4();
}
void perfromTaskInConcurrentQueue() {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.lptiyu.cn", DISPATCH_QUEUE_CONCURRENT);
    task0();
    dispatch_async(concurrentQueue, ^{
        task1();
        dispatch_sync(dispatch_get_main_queue(), ^{
            task2();
        });
        task3();
    });
    task4();
}
#pragma mark ---多任务，异步处理
//task number one
void taskForEnumerateNumberFrom0To5() {
    for (int i = 0; i < 5; i++) {
        NSLog(@"thread = %@---i = %d",[NSThread currentThread].description,i);
    }
}
//task number two
void taskForEnumerateNumberFrom5To10() {
    for (int i = 5; i < 10; i++) {
        NSLog(@"thread = %@---i = %d",[NSThread currentThread].description,i);
    }
}
//task number three
void taskForEnumerateNumberFrom10To15() {
    for (int i = 10; i < 15; i++) {
        NSLog(@"thread = %@---i = %d",[NSThread currentThread].description,i);
    }
}
//task number four
void taskForEnumerateNumberFrom15To20() {
    for (int i = 15; i < 20; i++) {
        NSLog(@"thread = %@---i = %d",[NSThread currentThread].description,i);
    }
}

/*
  异步依次执行 taskOne、taskTwo
 */

void performOneByOneTaskInAsync() {
   dispatch_queue_t serialQueue = dispatch_queue_create("com.lptiyu.cn", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        taskForEnumerateNumberFrom0To5();
    });
    dispatch_async(serialQueue, ^{
        taskForEnumerateNumberFrom5To10();
    });
    
}
/*
 异步同时执行 taskThree、taskFour
 */
void performConcurrentTaskInAsync() {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.lptiyu.cn", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(concurrentQueue, ^{
        taskForEnumerateNumberFrom10To15();
    });
    dispatch_async(concurrentQueue, ^{
        taskForEnumerateNumberFrom15To20();
    });
    
}
/*
 异步同时执行 taskOne、taskTwo
 */
void performGlobalQueueTaskInAsync() {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        taskForEnumerateNumberFrom10To15();
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        taskForEnumerateNumberFrom15To20();
    });
}

void preformAyncTaskByOperationQueue() {
    NSBlockOperation *operation0 = [NSBlockOperation blockOperationWithBlock:^{
        taskForEnumerateNumberFrom0To5();
    }];
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        taskForEnumerateNumberFrom5To10();
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        taskForEnumerateNumberFrom10To15();
    }];
    
    [operation2 addDependency:operation0];
    
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    operationQueue.maxConcurrentOperationCount = 2;
    [operationQueue addOperation:operation0];
    [operationQueue addOperation:operation1];
    [operationQueue addOperation:operation2];
    
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
     
    }
    
    return 0;
}








