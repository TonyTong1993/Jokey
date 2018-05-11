//
//  MercatorTrans.h
//  Location
//
//  Created by ZhengzhuanZi on 16/3/8.
//  Copyright © 2016年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MercatorTrans : NSObject
/**
 * web莫卡托转为经纬度
 *
 *  @param x x
 *  @param y y
 *
 *  @return
 */
+(CGPoint)transformMercator2LatLon:(double)x y:(double)y;
/**
 *  经纬度转莫卡托
 *
 *  @param lon
 *  @param lat
 *
 *  @return 
 */
+(CGPoint)transformLatLon2Mercator:(double)lon lat:(double)lat;

@end
