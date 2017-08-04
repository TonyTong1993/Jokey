//
//  TYHomeViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYHomeViewController.h"
#import "TYNetWorkingTool.h"
#import "TYTitleView.h"
@interface TYHomeViewController ()<ScrollPageViewDeleagte>

@end

@implementation TYHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        [dataSource addObject:@""];
       
       
    }
    self.dataSource = dataSource;
    TYTitleView *titleView = [[TYTitleView alloc] init];
    [titleView setDelegate:self handlerTitleClicked:^(NSUInteger index) {
        
    }];
    self.navigationItem.titleView = titleView;
}

-(void)setUpTableView {
    [super setUpTableView];
}
#pragma mark--
-(NSUInteger)numberOfTitlesInScrollPageView:(UIView *)scrollPageView {
    return 3;
}
-(NSString *)scrollPageView:(UIView *)scrollPageView titleForIndex:(NSUInteger)index {
    return @"推荐";
}
@end
