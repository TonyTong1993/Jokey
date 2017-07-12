//
//  TYBaseViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/12.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYBaseViewController.h"
#import  <MJRefresh/MJRefresh.h>
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
    
    //设置网络数据刷新
   MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
    }];
    [gifHeader.gifView setImage:[UIImage imageNamed:@"refresh"]];
    
    self.tableView.mj_header = gifHeader;
}

-(void)setUpNavigationBar {
    
}
//加载新数据
-(void)loadNewData {
    
}
//加载更多数据
-(void)loadMoreData {
    
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
