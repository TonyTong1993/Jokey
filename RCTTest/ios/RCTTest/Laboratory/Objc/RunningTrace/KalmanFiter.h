//
//  KalmanFiter.h
//  GPSEngineTest
//
//  Created by ZZHT on 2018/5/8.
//  Copyright © 2018年 ZZHT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TYKalmanFilter.h"
@interface KalmanFiter : NSObject

@property (nonatomic, assign) int intensity;//强度,默认值 = 3
@property (nonatomic, assign) float threshHold;//临界值、阈值，默认值 = 0.3f
@property (nonatomic, assign) int noiseThreshhold;//噪声极限、阈值，默认值 = 10


/**
 * 轨迹平滑优化
 * @param originlist 原始轨迹list,list.size大于2
 * @return 优化后轨迹list
 */
- (NSArray<KFCoordinate*>*)pathOptimize:(NSArray<KFCoordinate*>*)originlist;

/**
 * 轨迹线路滤波
 * @param originlist 原始轨迹list,list.size大于2
 * @return 滤波处理后的轨迹list
 */
- (NSArray<KFCoordinate*>*)kalmanFilterPath:(NSArray<KFCoordinate*>*)originlist;


/**
 * 轨迹去噪，删除垂距大于20m的点
 * @param originlist 原始轨迹list,list.size大于2
 * @return 去燥后的list
 */
- (NSArray<KFCoordinate*>*)removeNoisePoint:(NSArray<KFCoordinate*>*)originlist;

/**
 * 单点滤波
 * @param lastLoc 上次定位点坐标
 * @param curLoc 本次定位点坐标
 * @return 滤波后本次定位点坐标值
 */
- (KFCoordinate*)kalmanFilterPoint:(KFCoordinate*)lastLoc curLoc:(KFCoordinate*)curLoc;

/**
 * 轨迹抽稀
 * @param inPoints 待抽稀的轨迹list，至少包含两个点，删除垂距小于mThreshhold的点
 * @return 抽稀后的轨迹list
 */
- (NSArray<KFCoordinate*>*)reducerVerticalThreshold:(NSArray<KFCoordinate*>*)inPoints;

@end
