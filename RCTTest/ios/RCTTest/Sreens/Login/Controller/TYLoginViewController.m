//
//  TYLoginViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYLoginViewController.h"
#import "AppDelegate.h"
#import "TYTabBarController.h"
@interface TYLoginViewController ()

@end

@implementation TYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:HEXCOLOR(0x333333) forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginBtn];
}

-(void)loginAction {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:APP_Login_Key];
    
    //切换window视图
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow *window = app.window;
    TYTabBarController *rootVC = [[TYTabBarController alloc] init];
    window.rootViewController = rootVC;
    [window makeKeyAndVisible];
    
};

@end
