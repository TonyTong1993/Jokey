//
//  SavitzkyGolay.h
//  RCTTest
//
//  Created by ZZHT on 2018/5/15.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KFCoordinate;
@interface SavitzkyGolay : NSObject
/**
 * 轨迹平滑优化
 * @param originlist 原始轨迹list,list.size大于5
 * @return 优化后轨迹list
 */
- (NSArray<KFCoordinate*>*)pathOptimize:(NSArray<KFCoordinate*>*)originlist;

@end
