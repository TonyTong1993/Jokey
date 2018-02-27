//
//  AppDelegate+AppService.m
//  RCTTest
//
//  Created by 童万华 on 2018/2/27.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "TYLoginViewController.h"
#import "TYTabBarController.h"
#import "TYNetWorkingTool.h"
@implementation AppDelegate (AppService)
-(void)initService {
    //注册登录状态监听
    [kNotificationCenter addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];
    
    //网络状态监听
    [kNotificationCenter addObserver:self
                                             selector:@selector(netWorkStateChange:)
                                                 name:KNotificationNetWorkStateChange
                                               object:nil];
}
-(void)initWindow {
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
     [[UIButton appearance] setExclusiveTouch:YES];
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }

    [self.window makeKeyAndVisible];
}
-(void)initUserManager {
    //设置根视图
    /*1.0检查登录状态；2.0检测版本状态*/
    UIViewController *rootVC;
    if ([kUserDefaults boolForKey:APP_Login_Key]) {
        rootVC = [[TYTabBarController alloc] init];
    }else {
        rootVC = [[TYLoginViewController alloc] init];
    }
    self.window.rootViewController = rootVC;
}
-(void)netWorkConfig {
    YTKNetworkConfig *networkConfig = [YTKNetworkConfig sharedConfig];
    networkConfig.baseUrl = URL_main;
}
-(void)monitorNetWorkStatus {
    [[TYNetWorkingTool shareInstance] registerNetworkReachabilityManager:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                 DLog(@"网络环境：未知网络");
                
            case AFNetworkReachabilityStatusNotReachable:
                 DLog(@"网络环境：无网络");
                KPostNotification(KNotificationLoginStateChange, @(NO))
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                  DLog(@"网络环境：手机自带网络");
       
            case AFNetworkReachabilityStatusReachableViaWiFi:
                 DLog(@"网络环境：WiFi");
                KPostNotification(KNotificationNetWorkStateChange, @(YES))
                break;
        }
    }];
}
@end
