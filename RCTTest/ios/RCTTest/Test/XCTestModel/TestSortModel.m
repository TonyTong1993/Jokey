//
//  TestSortModel.m
//  Muti-Thread
//
//  Created by 童万华 on 2017/12/5.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TestSortModel.h"

@implementation TestSortModel
+(NSMutableArray *)selectSort:(NSMutableArray *)array {
    int k;
    for (int i = 0; i<array.count; i++) {
        k = i;
        for (int j = i+1; j<array.count; j++) { //找最小值
            if (array[k] >array[j]) {
                k = j;
            }
        }
        if (k!=i) {
            id temp = array[i];
            array[i]= array[k];
            array[k]= temp;
        }
    }
    
    return array;
}
+(NSMutableArray *)bubbleSort:(NSMutableArray *)array {
    int count = (int)array.count;
    for (int i = 0; i < count-1; i++) {
        for (int j = 0; j<count-1-i; j++) {
            if (array[j] >array[j+1]) {
                id temp = array[j+1];
                array[j+1]= array[j];
                array[j]= temp;
            }
        }
    }
    return array;
}
@end
