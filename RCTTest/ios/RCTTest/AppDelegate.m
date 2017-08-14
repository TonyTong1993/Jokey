//
//  AppDelegate.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/27.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "AppDelegate.h"
#import "Macro.h"
#import "TYTabBarController.h"
#import "TYTheme.h"
#import  <TBCityIconFont.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    TYTabBarController *root = [[TYTabBarController alloc] init];
    self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    //设置app主题
    [self setAppTheme];
    //设置iconfont
    [TBCityIconFont setFontName:@"iconfont"];
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
#pragma mark---设置主题
-(void)setAppTheme {
   UINavigationBar *navBar = [UINavigationBar appearance];
   NSString *themeColor = [TYTheme themeColorWithType:TYThemePureWhite];
   //设置主题颜色
    [navBar setBarTintColor:[UIColor colorWithHexString:themeColor]];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:[TYTheme themeFontFamilyName] size:18]}];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage imageNamed:@"tabbar_bg_1x49_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

@end
