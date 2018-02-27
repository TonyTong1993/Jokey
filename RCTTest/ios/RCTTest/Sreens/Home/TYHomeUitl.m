//
//  TYHomeUitl.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/10.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYHomeUitl.h"

@implementation TYHomeUitl
+(CGFloat)homeUitlGetCollectionViewHeight:(NSInteger)itemCount {
    CGFloat height = 200;
   
    
    switch (itemCount) {
        case 1:
            height = kRealValue(185);
            break;
        case 2:
            height = kRealValue(164);
            break;
        case 3:
             height = kRealValue(110);
            break;
        case 4:
             height = kRealValue(110);
            break;
        case 5:
             height = kRealValue(110);
            break;
        case 6:
             height = kRealValue(230);
            break;
        case 7:
             height = kRealValue(200);
            break;
        case 8:
             height = kRealValue(200);
            break;
        default:
             height = kRealValue(200);
            break;
    }
    return height;
}
@end
