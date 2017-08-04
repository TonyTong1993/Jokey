//
//  TYSegmentControlDelegate.h
//  RCTTest
//
//  Created by 童万华 on 2017/8/4.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol TYSegmentControlDelegate <NSObject>
-(void)segmentConrol:(UIView *)segmentView didSelectedItemAtIndex:(NSUInteger)index;
@end
