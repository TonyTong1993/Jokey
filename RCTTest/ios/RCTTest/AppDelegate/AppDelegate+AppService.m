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
@implementation AppDelegate (AppService)
-(void)initWindow {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.window.backgroundColor = [UIColor whiteColor];
    //设置根视图
    /*1.0检查登录状态；2.0检测版本状态*/
    
    UIViewController *rootVC;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:APP_Login_Key]) {
        rootVC = [[TYTabBarController alloc] init];
    }else {
        rootVC = [[TYLoginViewController alloc] init];
    }
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
}
@end
