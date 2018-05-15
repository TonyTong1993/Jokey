//
//  KalmanFiter.m
//  GPSEngineTest
//
//  Created by ZZHT on 2018/5/8.
//  Copyright © 2018年 ZZHT. All rights reserved.
//

#import "KalmanFiter.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKGeometry.h>


@interface KalmanFiter() {
    double lastLocation_x; //上次位置
    double currentLocation_x;//这次位置
    double lastLocation_y; //上次位置
    double currentLocation_y;//这次位置
    double estimate_x; //修正后数据
    double estimate_y; //修正后数据
    double pdelt_x; //自预估偏差
    double pdelt_y; //自预估偏差
    double mdelt_x; //上次模型偏差
    double mdelt_y; //上次模型偏差
    double gauss_x; //高斯噪音偏差
    double gauss_y; //高斯噪音偏差
    double kalmanGain_x; //卡尔曼增益
    double kalmanGain_y; //卡尔曼增益
    
    double m_R;
    double m_Q;
}



@end
@implementation KalmanFiter
-(instancetype)init {
    self = [super init];
    if (self) {
        self.intensity = 3;
        self.threshHold = 0.3f;
        self.noiseThreshhold = 10;
    }
    return self;
}
/**
 * 轨迹平滑优化
 * @param originlist 原始轨迹list,list.size大于2
 * @return 优化后轨迹list
 */
- (NSArray<KFCoordinate*>*)pathOptimize:(NSArray<KFCoordinate*>*)originlist {
    
    NSArray<KFCoordinate*>* list = [self removeNoisePoint:originlist];//去噪
    NSArray<KFCoordinate*>* afterList = [self kalmanFilterPath:list intensity:self.intensity];//滤波
    NSArray<KFCoordinate*>* pathoptimizeList = [self reducerVerticalThreshold:afterList threshHold:self.threshHold];//抽稀
    return pathoptimizeList;
}
/**
 * 轨迹线路滤波
 * @param originlist 原始轨迹list,list.size大于2
 * @return 滤波处理后的轨迹list
 */
- (NSArray<KFCoordinate*>*)kalmanFilterPath:(NSArray<KFCoordinate*>*)originlist {
    return [self kalmanFilterPath:originlist intensity:self.intensity];
}
/**
 * 轨迹去噪，删除垂距大于20m的点
 * @param originlist 原始轨迹list,list.size大于2
 * @return 去燥后的list
 */
- (NSArray<KFCoordinate*>*)removeNoisePoint:(NSArray<KFCoordinate*>*)originlist{
    return [self reduceNoisePoint:originlist threshHold:self.noiseThreshhold];
}
/**
 轨迹线路滤波器

 @param originList 轨迹位置集合
 @param intensity 滤波强度 （1-5）
 @return 滤波和的位置集合
 */
- (NSArray <KFCoordinate *> *)kalmanFilterPath:(NSArray <KFCoordinate *> *)originList
                                     intensity:(int)intensity {
    
    if (!originList || originList.count <= 2) {
        return  nil;
    }
    
     NSMutableArray<KFCoordinate*>* kalmanFilterList = [NSMutableArray array];
    //初始化滤波参数
    [self initial];
    
    KFCoordinate *coordinate = nil;
    KFCoordinate *lastCoordinate = [[KFCoordinate alloc] init];;
    lastCoordinate.latitude = [originList objectAtIndex:0].latitude;
    lastCoordinate.longitude = [originList objectAtIndex:0].longitude;
    [kalmanFilterList addObject:lastCoordinate];
    
    for (int i = 1; i < originList.count; i++) {
        KFCoordinate *curLoc = [originList objectAtIndex:i];
        coordinate = [self kalmanFilterPoint:lastCoordinate curLoc:curLoc intensity:intensity];
        if (coordinate) {
            [kalmanFilterList addObject:coordinate];
            lastCoordinate = coordinate;
        }
    }
    
    return  kalmanFilterList;
}

/**
 * 单点滤波
 * @param lastLoc 上次定位点坐标
 * @param curLoc 本次定位点坐标
 * @param intensity 滤波强度（1—5）
 * @return 滤波后本次定位点坐标值
 */
- (KFCoordinate *)kalmanFilterPoint:(KFCoordinate *)lastLoc
                             curLoc:(KFCoordinate *)curLoc
                          intensity:(int)intensity {
    if (!lastLoc || !curLoc) {
        return  nil;
    }
    
    if (pdelt_x == 0 || pdelt_y == 0) {
        [self initial];
    }
    
    KFCoordinate *coordinate = nil;
    if (intensity < 1) {
        intensity = 1;
    }else if (intensity > 5) {
        intensity = 5;
    }
    
    for (int j = 0; j < intensity; j++) {
        coordinate = [self kalmanFilter:lastLoc.longitude value_x:curLoc.longitude oldValue_y:lastLoc.latitude value_y:curLoc.latitude];
         curLoc = coordinate;
    }
    
    return coordinate;
    
}

/***************************卡尔曼滤波开始********************************/

/**
 初始化滤波参数
 */
- (void)initial {
    pdelt_x =  0.0001;
    pdelt_y =  0.0001;

    mdelt_x =  5.698402909980532E-4;
    mdelt_y =  5.698402909980532E-4;
}

- (KFCoordinate *)kalmanFilter:(double)oldValue_x
                       value_x:(double)value_x
                    oldValue_y:(double)oldValue_y
                       value_y:(double)value_y {
    lastLocation_x = oldValue_x;
    currentLocation_x= value_x;
    
    gauss_x = sqrt(pdelt_x * pdelt_x + mdelt_x * mdelt_x)+m_Q;     //计算高斯噪音偏差
    kalmanGain_x = sqrt((gauss_x * gauss_x)/(gauss_x * gauss_x + pdelt_x * pdelt_x)) +m_R; //计算卡尔曼增益
    estimate_x = kalmanGain_x * (currentLocation_x - lastLocation_x) + lastLocation_x;    //修正定位点
    mdelt_x = sqrt((1-kalmanGain_x) * gauss_x *gauss_x);      //修正模型偏差
    
    lastLocation_y = oldValue_y;
    currentLocation_y = value_y;
    gauss_y = sqrt(pdelt_y * pdelt_y + mdelt_y * mdelt_y)+m_Q;     //计算高斯噪音偏差
    kalmanGain_y = sqrt((gauss_y * gauss_y)/(gauss_y * gauss_y + pdelt_y * pdelt_y)) +m_R; //计算卡尔曼增益
    estimate_y = kalmanGain_y * (currentLocation_y - lastLocation_y) + lastLocation_y;    //修正定位点
    mdelt_y = sqrt((1-kalmanGain_y) * gauss_y * gauss_y);      //修正模型偏差
    
    KFCoordinate *coordinate = [[KFCoordinate alloc] init];
    coordinate.longitude = estimate_x;
    coordinate.latitude = estimate_y;
    
    return coordinate;
    
}
/***************************卡尔曼滤波结束**********************************/

/***************************抽稀算法*************************************/
- (NSArray<KFCoordinate*>*)reducerVerticalThreshold:(NSArray<KFCoordinate*>*)inPoints threshHold:(float)threshHold {
    if(inPoints.count < 2) {
        return inPoints;
    }
    
    NSMutableArray *ret = [NSMutableArray arrayWithCapacity:inPoints.count];
    
    for(int i = 0; i < inPoints.count; ++i) {
        KFCoordinate *pre = ret.lastObject;
        KFCoordinate *cur = [inPoints objectAtIndex:i];
        
        
        if (!pre || i == inPoints.count - 1) {
            [ret addObject:[inPoints objectAtIndex:i]];
            continue;
        }
        
        KFCoordinate *next = [inPoints objectAtIndex:(i + 1)];
        
        CLLocationCoordinate2D curCoordinate = CLLocationCoordinate2DMake(cur.latitude, cur.longitude);
        CLLocationCoordinate2D preCoordinate = CLLocationCoordinate2DMake(pre.latitude, pre.longitude);
        CLLocationCoordinate2D nextCoordinate = CLLocationCoordinate2DMake(next.latitude, next.longitude);
        
        MKMapPoint curP = MKMapPointForCoordinate(curCoordinate);
        MKMapPoint prevP = MKMapPointForCoordinate(preCoordinate);
        MKMapPoint nextP = MKMapPointForCoordinate(nextCoordinate);
        double distance = [self calculateDistanceFromPoint:curP lineBegin:prevP lineEnd:nextP];
        if (distance >= threshHold) {
            [ret addObject:cur];
        }
    }
    
    return ret;
}
- (KFCoordinate*)getLastLocation:(NSArray<KFCoordinate*>*)oneGraspList {
    if (!oneGraspList || oneGraspList.count == 0) {
        return nil;
    }
    NSInteger locListSize = oneGraspList.count;
    KFCoordinate* lastLocation = [oneGraspList objectAtIndex:(locListSize - 1)];
    return lastLocation;
}
/**
 * 计算当前点到线的垂线距离
 * @param pt 当前点
 * @param begin 线的起点
 * @param end 线的终点
 *
 */
- (double)calculateDistanceFromPoint:(MKMapPoint)pt
                           lineBegin:(MKMapPoint)begin
                             lineEnd:(MKMapPoint)end {

    MKMapPoint mappedPoint;
    double dx = begin.x - end.x;
    double dy = begin.y - end.y;
    if(fabs(dx) < 0.00000001 && fabs(dy) < 0.00000001 ) {
        mappedPoint = begin;
    } else {
        double u = (pt.x - begin.x)*(begin.x - end.x) +
        (pt.y - begin.y)*(begin.y - end.y);
        u = u/((dx*dx)+(dy*dy));

        mappedPoint.x = begin.x + u*dx;
        mappedPoint.y = begin.y + u*dy;
    }

    return MKMetersBetweenMapPoints(pt, mappedPoint);
}
/***************************抽稀算法结束*********************************/

- (NSArray<KFCoordinate*>*)reduceNoisePoint:(NSArray<KFCoordinate*>*)inPoints threshHold:(float)threshHold {
    if (!inPoints) {
        return nil;
    }
    if (inPoints.count <= 2) {
        return inPoints;
    }
    
    NSMutableArray<KFCoordinate*>* ret = [NSMutableArray array];
    for (int i = 0; i < inPoints.count; i++) {
        KFCoordinate* pre = [self getLastLocation:ret];
        KFCoordinate* cur = [inPoints objectAtIndex:i];
        if (!pre || i == inPoints.count - 1) {
            [ret addObject:cur];
            continue;
        }
        KFCoordinate* next = [inPoints objectAtIndex:(i + 1)];
        
        MKMapPoint curP = MKMapPointForCoordinate(CLLocationCoordinate2DMake(cur.latitude, cur.longitude));
        MKMapPoint prevP = MKMapPointForCoordinate(CLLocationCoordinate2DMake(pre.latitude, pre.longitude));
        MKMapPoint nextP = MKMapPointForCoordinate(CLLocationCoordinate2DMake(next.latitude, next.longitude));
        double distance = [self calculateDistanceFromPoint:curP lineBegin:prevP lineEnd:nextP];
        if (distance < threshHold){
            [ret addObject:cur];
        }
    }
    return ret;
}
@end
