//
//  GaoDeCoorTrans.m
//  Location
//
//  Created by ZhengzhuanZi on 16/3/6.
//  Copyright © 2016年 Location. All rights reserved.
//

#import "GaoDeCoorTrans.h"

#define pi 3.14159265358979324
#define a 6378245.0
#define ee 0.00669342162296594323


@implementation GaoDeCoorTrans

+(CGPoint)transform:(double)wgLat lon:(double)wgLon {
    double tlat = 0.0,tlon = 0.0;

    if ([GaoDeCoorTrans outOfChina:wgLat lon:wgLon] ) {
        tlat = wgLat;
        tlon = wgLon;
        return CGPointMake(tlat, tlon);
    }
    double dLat = [GaoDeCoorTrans transformLat:(wgLon - 105.0) y:(wgLat - 35.0)];
    double dLon = [GaoDeCoorTrans transformLon:(wgLon - 105.0) y:(wgLat - 35.0)];
    double radLat = wgLat / 180.0 * pi;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0)
				/ ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
    dLon = (dLon * 180.0)
				/ (a / sqrtMagic * cos(radLat) * pi);
    
    tlat = wgLat + dLat;
    tlon = wgLon + dLon;
    
    return CGPointMake(tlat, tlon);
}

+(BOOL)outOfChina:(double)lat lon:(double)lon {
    if (lon < 72.004 || lon > 137.8347) {
        return true;
    }
    
    if (lat < 0.8293 || lat > 55.8271) {
        return true;
    }
    return false;
}

+(double) transformLat:(double)x y:(double)y {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y
				+ 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x
                                                            * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0
                                                      * pi)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y
                                                             * pi / 30.0)) * 2.0 / 3.0;
    return ret;
}

+(double) transformLon:(double)x y:(double)y {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1
				* sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x
                                                            * pi)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0
                                                      * pi)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x
                                                               / 30.0 * pi)) * 2.0 / 3.0;
    return ret;
}
@end
