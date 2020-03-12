//
//  GaoDeCoorTrans.h
//  Location
//
//  Created by ZhengzhuanZi on 16/3/6.
//  Copyright © 2016年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GaoDeCoorTrans : NSObject
/**
 * 进行坐标转换，将WGS84 的经纬度转成高德地图平面坐标
 *
 *  @param wgLat WGS84纬度，以度为单位
 *  @param wgLon WGS84经度，以度为单位
 *
 *  @return 转换后的高德地图102113平面坐标
 */
+(CGPoint)transform:(double)wgLat lon:(double)wgLon;
@end
