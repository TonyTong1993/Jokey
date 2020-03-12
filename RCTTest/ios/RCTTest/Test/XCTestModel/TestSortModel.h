//
//  TestSortModel.h
//  Muti-Thread
//
//  Created by 童万华 on 2017/12/5.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestSortModel : NSObject

/**
 选择排序
以升序为例
 1.假定第一个元素是最小值，依次比较，交换最小元素到第一位置，依次重复直到区域不可在缩小。
 */
+(NSMutableArray *)selectSort:(NSMutableArray *)array;
/*
 冒泡算法是一种基础的排序算法，这种算法会重复的比较数组中相邻的两个元素。如果一个元素比另一个元素大（小），那么就交换这两个元素的位置。重复这一比较直至最后一个元素。这一比较会重复n-1趟，每一趟比较n-j次，j是已经排序好的元素个数。每一趟比较都能找出未排序元素中最大或者最小的那个数字。这就如同水泡从水底逐个飘到水面一样。冒泡排序是一种时间复杂度较高，效率较低的排序方法。其空间复杂度是O(n)
 */
+(NSMutableArray *)bubbleSort:(NSMutableArray *)array;

+(void)insertSort:(NSMutableArray *)array;

+(void)fastSort:(NSMutableArray *)array;

@end
