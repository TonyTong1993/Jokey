//
//  MercatorTrans.m
//  Location
//
//  Created by ZhengzhuanZi on 16/3/8.
//  Copyright © 2016年 Location. All rights reserved.
//

#import "MercatorTrans.h"

@implementation MercatorTrans

+(CGPoint)transformMercator2LatLon:(double)x y:(double)y {
    double pi = 3.14159265358979324;
    double tlat = x/20037508.34*180;
    double tlon = y/20037508.34*180;
    tlon= 180/pi*(2*atan(exp(tlon*pi/180))-pi/2);
    
    return CGPointMake(tlat, tlon);
}

+(CGPoint)transformLatLon2Mercator:(double)lon lat:(double)lat {
    if(fabs(lon) > 180.0 || fabs(lat)>90.0){
        return CGPointZero;
    }
    
    double pi = 3.14159265358979324;
    double x = lon *20037508.342789/180;
    
    double y = log(tan((90+lat)*pi/360))/(pi/180);
    
    y = y *20037508.34789/180;
    return CGPointMake(x, y);
}
@end
