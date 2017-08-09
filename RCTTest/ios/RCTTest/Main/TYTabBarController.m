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
@interface TYTabBarController ()

@end

@implementation TYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *barItemInfos = @[
                              @{@"className":@"TYHomeViewController",@"icon":@"pfb_tabbar_homepage",@"selectedIcon":@"pfb_tabbar_homepage_selected",@"title":@"首页"},
                              @{@"className":@"TYMailViewController",@"icon":@"pfb_tabbar_discover",@"selectedIcon":@"pfb_tabbar_discover_selected",@"title":@"商城"},
                              @{@"className":@"TYVideoController",@"icon":@"pfb_tabbar_merchant",@"selectedIcon":@"pfb_tabbar_merchant_selected",@"title":@"视频"},
                              @{@"className":@"TYProfileViewController",@"icon":@"pfb_tabbar_mine",@"selectedIcon":@"pfb_tabbar_mine_selected",@"title":@"我的"}
                              ];
    for (NSDictionary *dict in barItemInfos) {
        [self addChildViewController:dict[@"className"] icon:dict[@"icon"] selectedIcon:dict[@"selectedIcon"] title:dict[@"title"]];
    }
}

-(void)addChildViewController:(NSString *)className icon:(NSString *)icon selectedIcon:(NSString *)selectedIcon title:(NSString *)title {
    UIViewController *childController;
     if ([className isEqualToString:@"TYVideoController"]) {
        childController = [[TYVideoController alloc] init];
     }else {
        childController = [[NSClassFromString(className) alloc] init];
     }
    childController.title = title;
//    childController.view.backgroundColor = [UIColor randomColor];
    TYNavigationController *nav = [[TYNavigationController alloc] initWithRootViewController:childController];
    UITabBarItem *barItem = childController.tabBarItem;
    [barItem setImage:[UIImage imageNamed:icon]];
    [barItem setSelectedImage:[UIImage imageNamed:selectedIcon]];
    [barItem setTitle:title];
    [barItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:7/255.0 green:185/255.0 blue:165/255.0 alpha:1.0]} forState:UIControlStateSelected];
    [self addChildViewController:nav];
}

@end
