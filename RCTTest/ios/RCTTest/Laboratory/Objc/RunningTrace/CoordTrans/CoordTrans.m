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
 

@end
