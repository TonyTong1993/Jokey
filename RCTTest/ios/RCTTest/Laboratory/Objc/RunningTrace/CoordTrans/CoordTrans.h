//
//  CoordTrans.h
//  Location
//
//  Created by ZhengzhuanZi on 16/3/8.
//  Copyright © 2016年 Location. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CoordTrans : NSObject
+(CGPoint)transform2LatLon:(double)x y:(double)y;
+(CGPoint)transform2Local:(double)lon lat:(double)lat;
@end
