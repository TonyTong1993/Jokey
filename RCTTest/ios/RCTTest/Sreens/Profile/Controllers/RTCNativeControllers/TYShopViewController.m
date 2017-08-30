//
//  TYShopViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/29.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYShopViewController.h"

@interface TYShopViewController ()

@end

@implementation TYShopViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:true];
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
   
    [self.navigationController.navigationBar setHidden:false];
}


@end
