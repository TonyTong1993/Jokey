//
//  CoordTrans.m
//  Location
//
//  Created by ZhengzhuanZi on 16/3/8.
//  Copyright © 2016年 Location. All rights reserved.
//

#import "CoordTrans.h"
#import "MercatorTrans.h"
#import "GaoDeCoorTrans.h"

@implementation CoordTrans
+(CGPoint)transform2LatLon:(double)x y:(double)y {
    return [MercatorTrans transformMercator2LatLon:x y:y];
}

+(CGPoint)transform2Local:(double)lon lat:(double)lat {
    CGPoint point = [GaoDeCoorTrans transform:lat lon:lon];
    return [MercatorTrans transformLatLon2Mercator:point.y lat:point.x];
}
- (NSDictionary *)locationMarsFromEarth_earthLat:(double)latitude earthLon:(double)longitude {
    // 首先判断坐标是否属于天朝
    if (![self isInChinaWithlat:latitude lon:longitude]) {
        return @{@"latitude":@(latitude),
                 @"longitude":@(longitude)
                 };
    }
    double a = 6378245.0;
    double ee = 0.00669342162296594323;
    
    double dLat = [self transform_earth_from_mars_lat_lat:(latitude - 35.0) lon:(longitude - 35.0)];
    double dLon = [self transform_earth_from_mars_lng_lat:(latitude - 35.0) lon:(longitude - 35.0)];
    double radLat = latitude / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    
    double newLatitude = latitude + dLat;
    double newLongitude = longitude + dLon;
    NSDictionary *dic = @{@"latitude":@(newLatitude),
                          @"longitude":@(newLongitude)
                          };
    return dic;
}
- (BOOL)isInChinaWithlat:(double)lat lon:(double)lon {
    if (lon < 72.004 || lon > 137.8347)
        return NO;
    if (lat < 0.8293 || lat > 55.8271)
        return NO;
    return YES;
}
- (double)transform_earth_from_mars_lat_lat:(double)y lon:(double)x {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 3320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

- (double)transform_earth_from_mars_lng_lat:(double)y lon:(double)x {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

@end
