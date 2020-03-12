//
//  AppDelegate.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/27.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "AppDelegate.h"
#import "Macro.h"
#import "TYTheme.h"
#import  "TBCityIconFont.h"
#import "AppDelegate+AppService.h"
#if !TARGET_IPHONE_SIMULATOR
#import "AppDelegate+PushService.h"
#endif
#import "AppManager.h"

#ifdef PUREUI

#else


#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //初始化window
    [self initWindow];
    //初始化网络配置
    [self netWorkConfig];
    //初始化友盟服务
    [self initUmeng];
    //初始化app服务
    [self initService];
    //初始化用户系统
    [self initUserManager];
    //网络监听
    [self monitorNetWorkStatus];
   
#if DEBUG
    [AppManager showFPS];
#else
    //开启启动广告
    [AppManager appADStart];
    [self initRemoteNotification:launchOptions];
#endif
   
    //设置iconfont
    [TBCityIconFont setFontName:@"iconfont"];
    if (@available(iOS 13.0, *)) {
        _window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    } else {
            
    }

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
