//
//  AppManager.h
//  RCTTest
//
//  Created by 童万华 on 2018/2/27.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppManager : NSObject

/**
 开启运用启动广告
 */
+(void)appADStart;

/**
 开启实时监测FPS
 */
+(void)showFPS;
@end
