//
//  TYBaseViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/12.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYBaseViewController.h"

@interface TYBaseViewController ()

@end

@implementation TYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self setUpNavigationBar];
}

-(void)setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //去除footer样式
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}

-(void)setUpNavigationBar {
    
}


#pragma mark---UITableViewDataSource and UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[UITableViewCell alloc] init];
}
@end
