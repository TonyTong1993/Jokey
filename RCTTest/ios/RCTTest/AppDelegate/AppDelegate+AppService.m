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
#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>
#import <UMErrorCatch/UMErrorCatch.h>
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
//TODO:通过黑魔法完成页面统计
-(void)initUmeng {
    [UMConfigure initWithAppkey:UMAppKey channel:AppChannel];
    [UMConfigure setEncryptEnabled:YES];
    [UMErrorCatch initErrorCatch];
    
}
+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
-(UIViewController *)rootViewController {
    UIViewController *result = nil;
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    if (keyWindow.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                keyWindow = window;
                break;
            }
        }
    }
    UIView *frontView = [[keyWindow subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    }else {
        result = keyWindow.rootViewController;
    }
    return result;
}
-(UIViewController *)topViewController {
    UIViewController *superVC = [self rootViewController];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        UIViewController *tabSelectVC = [(UITabBarController *)superVC selectedViewController];
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            return [(UINavigationController *)tabSelectVC topViewController];
        }else {
            return tabSelectVC;
        }
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            return [(UINavigationController *)superVC topViewController];
        }
        return superVC;
}
#pragma mark---notification
-(void)loginStateChange:(NSNotification *)notification {
    
}
-(void)netWorkStateChange:(NSNotification *)notification {
    
}
@end
