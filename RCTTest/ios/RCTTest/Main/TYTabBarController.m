//
//  TYTabBarController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYTabBarController.h"
#import "TYNavigationController.h"
#import "RCTTest-Swift.h"
CFAbsoluteTime StartTime;
@interface TYTabBarController ()

@end

@implementation TYTabBarController

- (void)viewDidLoad {
    /*从main加载到这的时间*/
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"didload in %f sec",CFAbsoluteTimeGetCurrent() - StartTime);
    });
    [super viewDidLoad];
    NSArray *barItemInfos = @[
                              @{@"className":@"TYHomeViewController",@"icon":@"tabbar_featured_24x24_",@"selectedIcon":@"tabbar_featured_hl_24x24_",@"title":@"首页"},
                              @{@"className":[NSString nameSpaceWrapedClassNameInSwift:@"TYAttentionViewController"],@"icon":@"tabbar_follow_24x24_",@"selectedIcon":@"tabbar_follow_hl_24x24_",@"title":@"关注"},
                              @{@"className":[NSString nameSpaceWrapedClassNameInSwift:@"TYDiscoverViewController"],@"icon":@"tabbar_explore_24x24_",@"selectedIcon":@"tabbar_explore_hl_24x24_",@"title":@"发现"},
                             @{@"className":[NSString nameSpaceWrapedClassNameInSwift:@"TYMessageViewController"],@"icon":@"tabbar_remind_24x24_",@"selectedIcon":@"tabbar_remind_hl_24x24_",@"title":@"消息"},
                             @{@"className":@"TYProfileViewController",@"icon":@"tabbar_profile_24x24_",@"selectedIcon":@"tabbar_profile_hl_24x24_",@"title":@"我的"},
                              ];
    for (NSDictionary *dict in barItemInfos) {
        [self addChildViewController:dict[@"className"] icon:dict[@"icon"] selectedIcon:dict[@"selectedIcon"] title:dict[@"title"]];
    }
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"didAppear in %f sec",CFAbsoluteTimeGetCurrent() - StartTime);
    });
}
-(void)addChildViewController:(NSString *)className icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon title:(NSString *)title {
    UIViewController *childController = [[NSClassFromString(className) alloc] init];
    childController.title = title;
    TYNavigationController *nav = [[TYNavigationController alloc] initWithRootViewController:childController];
    UITabBarItem *barItem = childController.tabBarItem;
    [barItem setImage:[[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [barItem setSelectedImage:[[UIImage imageNamed:selectedIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [barItem setTitle:title];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HEXCOLOR(0x52B5EF)} forState:UIControlStateSelected];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:HEXCOLOR(0xB3B2BA)} forState:UIControlStateNormal];
    [self addChildViewController:nav];
}

@end
