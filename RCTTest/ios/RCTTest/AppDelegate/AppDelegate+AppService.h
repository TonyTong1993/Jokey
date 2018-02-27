//
//  AppDelegate+AppService.h
//  RCTTest
//
//  Created by 童万华 on 2018/2/27.
//  Copyright © 2018年 童万华. All rights reserved.
//


#import "AppDelegate.h"
@interface AppDelegate (AppService)

/**
 初始化window
 */
-(void)initWindow;

/**
 初始化网络配置
 */
-(void)netWorkConfig;

/**
 初始化友盟
 */
-(void)initUmeng;

/**
 初始化app服务
 */
-(void)initService;

/**
 初始化用户系统
 */
-(void)initUserManager;

/**
 监听网络配置变化
 */
-(void)monitorNetWorkStatus;

/**
 返回window上栈顶的viewController

 @return viewContoller
 */
-(UIViewController *)topViewController;

/**
 返回window顶层的容器类型的viewController

 @return like tabBarViewController or navigationViewController
 */
-(UIViewController *)topContainerViewController;

@end
