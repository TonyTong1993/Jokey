//
//  AppDelegate+PushService.m
//  RCTTest
//
//  Created by 童万华 on 2018/2/27.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "AppDelegate+PushService.h"

@implementation AppDelegate (PushService)
-(void)initRemoteNotification:(NSDictionary *)launchOptions {
    //    设置高德地图的key
    [[AMapServices sharedServices] setApiKey:AMapKey];
    //    支持https
    [[AMapServices sharedServices] setEnableHTTPS:true];
    //设置本地推送通知 步骤：1.注册本地通知；2.设置本地推送消息；3.显示推送消息代理
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
        
        
        //            [self pushLocalNotification];
        
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
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
        notification.fireDate = date;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval = NSCalendarUnitDay;
        notification.applicationIconBadgeNumber = 1;
        // 通知被触发时播放的声音
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.alertBody = @"起床啦！";
        notification.userInfo = @{@"task":@"学习iOS课程"};
        notification.applicationIconBadgeNumber = 1;
        //        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        // 执行通知注册
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
    
    /*注册远程推送*/
    //Required
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    /* Required
     // init Push
     // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
     // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
     appKey:
     channel:
     apsForProduction:
     advertisingIdentifier:
     */
    [JPUSHService setupWithOption:launchOptions appKey:JSPUSHKey
                          channel:@""
                 apsForProduction:false
            advertisingIdentifier:advertisingId];
}

-(void)pushLocalNotification {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"起床啦！";
    content.subtitle = @"8:00洗漱";
    content.body = @"完成之后学习iOS";
    content.badge = @1;
    
    NSString *identifier = @"0000-1111-0000-0000";
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"icon_certification@2x" withExtension:@"png"];
    NSError *error = nil;
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:identifier URL:url options:nil error:&error];
    if (error) {
        NSLog(@"attachment error %@", [error localizedDescription]);
    }
    content.attachments = @[attachment];
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
#pragma mark--本地推送通知 ios version 8-10
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据
    NSString *notMess = [notification.userInfo objectForKey:@"key"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本地通知(前台)"
                                                    message:notMess
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    // 更新显示的徽章个数
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    completionHandler();
}
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler {
    completionHandler();
}
#pragma mark--UNUserNotificationCenterDelegate  ios version > 10.0
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert);
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    completionHandler();
}

#pragma mark--remote notification
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
@end
