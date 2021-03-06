//
//  TYNavigationController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYNavigationController.h"
#import "UIImage+Extentions.h"
#import "TYPoprosManager.h"
#import "TYShopViewController.h"

@interface TYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation TYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置app主题
    [self setAppTheme];
}


#pragma mark---设置主题
-(void)setAppTheme {
    UINavigationBar *navBar = [UINavigationBar appearance];
    NSString *themeColor = [TYTheme themeColorWithType:TYThemePureWhite];
    //设置主题颜色
    [navBar setBarTintColor:HEXCOLOR(themeColorHexValue)];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    [navBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_1x64_"] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage imageWithColor:HEXCOLOR(0xe0e0e0)]];
    
}

#pragma mark---自定义push
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count >= 1) {
        //当非根视图时隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        //自定义返回按钮
 
        
    }
    [super pushViewController:viewController animated:animated];
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    UIViewController *lastVC = self.childViewControllers.lastObject;
    
    if (self.childViewControllers.count == 2) {
        NSInteger number = [TYPoprosManager sharePoprosManager].poproLeng;
        if (number > 0) {
            return false;
        }else {
            return true;
        }
    }
    return YES;
}

@end
