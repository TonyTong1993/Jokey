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
#import "TYLoginViewController.h"
#import "TYTheme.h"
#import  "TBCityIconFont.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //设置window
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
    //设置iconfont
    [TBCityIconFont setFontName:@"iconfont"];
//    设置高德地图的key
    [[AMapServices sharedServices] setApiKey:AMapKey];
//    支持https
    [[AMapServices sharedServices] setEnableHTTPS:true];
    //设置本地推送通知 步骤：1.注册本地通知；2.设置本地推送消息；3.
    /*设置iOS11版本的推送通知*/
    if (NSClassFromString(@"UNUserNotificationCenter")) {
        UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
            NSLog(@"granted = %d",granted);
        }];
//        [center setNotificationCategories:NULL];
        [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
           
        }];

   
            [self pushLocalNotification];
     
    }else {
        UIUserNotificationType type = UIUserNotificationTypeAlert;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
        // 处理退出后通知的点击，程序启动后获取通知对象，如果是首次启动还没有发送通知，那第一次通知对象为空，没必要去处理通知（如跳转到指定页面）
        if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
            UILocalNotification *localNotifi = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
            NSLog(@"localNotifi = %@",localNotifi);
        }
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60];
        notification.fireDate = date;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval = NSCalendarUnitDay;
        notification.alertBody = @"起床啦！";
        notification.userInfo = @{@"task":@"学习iOS课程"};
        notification.applicationIconBadgeNumber = 1;
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    }
    
    
    
    return YES;
}
-(void)pushLocalNotification {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"起床啦！";
    content.subtitle = @"8:00洗漱";
    content.body = @"完成之后学习iOS";
    content.badge = @1;
    
//    NSString *identifier = @"0000-1111-0000-0000";
//    NSURL *url = [[NSBundle mainBundle] pathForResource:@"icon_certification@2x" ofType:@"png"];
//    NSError * __autoreleasing *error = NULL;
//    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:url options:nil error:error];
//    if (error) {
//        NSLog(@"attachment error %@", error);
//    }
//    content.attachments = @[attachment];
    content.launchImageName = @"icon_certification";
    
    // 2.设置声音
    UNNotificationSound *sound = [UNNotificationSound defaultSound];
    content.sound = sound;
    
    // 3.触发模式
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"TestRequest0" content:content trigger:trigger];
    
     UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

    }];
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
//本地推送通知
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
     NSLog(@"localNotifi = %@",notification);
}
#pragma mark--UNUserNotificationCenterDelegate  ios version > 10.0
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
      completionHandler(UNNotificationPresentationOptionAlert);
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    completionHandler();
}
@end
