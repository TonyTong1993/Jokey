//
//  AppDelegate+PushService.h
//  RCTTest
//
//  Created by 童万华 on 2018/2/27.
//  Copyright © 2018年 童万华. All rights reserved.
//


#import "AppDelegate.h"
// 如果需要使用idfa功能所需要引入的头文件（可选）
#if !TARGET_IPHONE_SIMULATOR
#import <AdSupport/AdSupport.h>
#import <UserNotifications/UserNotifications.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#endif
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate (PushService)<UNUserNotificationCenterDelegate>
-(void)initRemoteNotification:(NSDictionary *)launchOptions;
@end
#if !TARGET_IPHONE_SIMULATOR
@interface AppDelegate (PushService)<JPUSHRegisterDelegate>
@end
#endif
