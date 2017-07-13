//
//  TYHomeViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYHomeViewController.h"
#import "TYNetWorkingTool.h"
@interface TYHomeViewController ()

@end

@implementation TYHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        [dataSource addObject:@""];
    }
    self.dataSource = dataSource;
    
}

-(void)setUpTableView {
    [super setUpTableView];
}

@end
