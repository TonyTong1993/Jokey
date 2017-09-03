//
//  TYMailViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYMailViewController.h"
#import <React/RCTRootView.h>
#import "TYRCTViewController.h"
@interface TYMailViewController ()

@end

@implementation TYMailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    btn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(handleClicked) forControlEvents:UIControlEventTouchUpInside];
    btn.center = self.view.center;
}

-(void)handleClicked {
    NSURL *jsCodeLocation = [NSURL
                             URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                         moduleName        : @"test"
                         initialProperties :@{@"content":@"I am fron OC Code"}
                          launchOptions    : nil];
    TYRCTViewController *vc = [[TYRCTViewController alloc] init];
    vc.view = rootView;
    
    [self presentViewController:vc animated:true completion:^{
        
    }];
}

@end
