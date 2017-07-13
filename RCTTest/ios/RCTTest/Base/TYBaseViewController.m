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
@property (nonatomic) NSMutableArray *normalImages;
@property (nonatomic) NSMutableArray *refreshImages;
@end

@implementation TYBaseViewController
#pragma mark---getter and setter
- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        for (int i = 95; i > 82; i--) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_00%d",i]];
            [_normalImages addObject:image];
        }
        
    }
    return _normalImages;
}

//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];
        
        for (int i = 82; i > 0; i--) {
            UIImage *image;
            if (i > 9) {
                image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_00%d",i]];
            }else {
                image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_000%d",i]];
            }
            [_refreshImages addObject:image];
        }
    }
    return _refreshImages;
}
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
       NSLog(@"gifHeader-------");
    }];

    [gifHeader setImages:self.refreshImages  forState:MJRefreshStateRefreshing];
    [gifHeader setImages:self.normalImages forState:MJRefreshStateIdle];
    [gifHeader setImages:self.normalImages  forState:MJRefreshStatePulling];
    gifHeader.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    gifHeader.stateLabel.hidden = YES;
    [gifHeader beginRefreshing];
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
