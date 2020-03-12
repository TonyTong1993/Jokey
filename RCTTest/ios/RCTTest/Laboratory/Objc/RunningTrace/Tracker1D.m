//
//  Tracker1D.m
//  RCTTest
//
//  Created by ZZHT on 2018/5/17.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "Tracker1D.h"
@interface Tracker1D() {
    //time step
    double mt,mt2,mt2d2,mt3d2,mt4d4;
    // process noise covariance
    double mQa,mQb,mQc,mQd;
    //estimated state
    double mXa,mXb;
    //estimated covariance
    double mPa,mPb,mPc,mPd;

}

@end
@implementation Tracker1D

/**
 init

 @param timeStep 时间频次
 @param noise 噪声系数
 @return self
 */
-(instancetype)initWithTimeStep:(double)timeStep
                   processNoise:(double)noise {
    
    self = [super init];
    if (self) {
        mt = timeStep;
        mt2 = mt * mt;
        mt2d2 = mt2 / 2.0;
        mt3d2 = mt2 * mt / 2.0;
        mt4d4 = mt2 *mt2 / 4.0;
        
        //process noise covariance
        double n2 = noise * noise;
        mQa = n2 * mt4d4;
        mQb = n2 * mt3d2;
        mQc = mQb;
        mQd = n2 *mt2;
        
        //estimated covariance
        mPa = mQa;
        mPb = mQb;
        mPc = mQc;
        mPd = mQd;
    }
    
    return self;
}

/**
 Reset the filter to the given state

 @param position 值
 @param velocity 速度
 @param noise 噪声系数
 */
-(void)setState:(double)position
       velocity:(double)velocity
          noise:(double)noise {
    //state vector
    mXa = position;
    mXb = velocity;
    
    //covariance
    double n2  = noise *noise;
    mPa = n2 * mt4d4;
    mPb = n2 * mt3d2;
    mPc = mPb;
    mPd = n2 * n2;
}

/**
 Correct with the given measurement

 @param position 值
 @param noise 噪声系数
 */
-(void)update:(double)position
        noise:(double)noise  {
    double r = noise * noise;
    
    double y = position - mXa;
    
    double s = mPa + r;
    double si = 1.0 / s;
    
    double Ka = mPa * si;
    double Kb = mPc * si;
    
    mXa = mXa + Ka * y;
    mXb = mXb + Kb * y;
    
    
    double Pa = mPa - Ka *mPa;
    double Pb = mPb - Ka *mPb;
    double Pc = mPc - Ka *mPc;
    double Pd = mPd - Ka *mPd;
    
    mPa = Pa;
    mPb = Pb;
    mPc = Pc;
    mPd = Pd;
}

-(void)predict:(double)accleration {
    mXa = mXa + mXb * mt + accleration *mt2d2;
    mXb = mXb + accleration * mt;
    
    double FPFtd = mPd;
    double Pdt = mPd * mt;
    double FPFtb = mPb + Pdt;
    double FPFta = mPa + mt * (mPc + FPFtb);
    double FPFtc = mPc + Pdt;
    
    mPa = FPFta + mQa;
    mPb = FPFtb + mQb;
    mPc = FPFtc + mQc;
    mPd = FPFtd + mQd;
}

@end
