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
            height = 185*SCREEN_WIDTH_SCALE;
            break;
        case 2:
            height = 164*SCREEN_WIDTH_SCALE;
            break;
        case 3:
             height = 110*SCREEN_WIDTH_SCALE;;
            break;
        case 4:
             height = 230*SCREEN_WIDTH_SCALE;
            break;
        case 5:
             height = 230*SCREEN_WIDTH_SCALE;
            break;
        case 6:
             height = 230*SCREEN_WIDTH_SCALE;
            break;
        case 7:
             height = 200*SCREEN_WIDTH_SCALE;
            break;
        case 8:
             height = 200*SCREEN_WIDTH_SCALE;
            break;
        default:
             height = 200*SCREEN_WIDTH_SCALE;
            break;
    }
    return height;
}
@end
