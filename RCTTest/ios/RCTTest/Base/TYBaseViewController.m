//
//  TYBaseViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/12.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYBaseViewController.h"
#import "UIImage+Extentions.h"

@interface TYBaseViewController ()
@property (nonatomic) NSMutableArray *normalImages;
@property (nonatomic) NSMutableArray *pullingImages;
@property (nonatomic) NSMutableArray *refreshImages;
@end

@implementation TYBaseViewController
#pragma mark---getter and setter
- (NSMutableArray *)normalImages
{
    if (_normalImages == nil) {
        _normalImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_to_refresh_%d_54x54_",i+1]];
            [_normalImages addObject:image];
        }
        
    }
    return _normalImages;
}
- (NSMutableArray *)pullingImages
{
    if (_pullingImages == nil) {
        _pullingImages = [[NSMutableArray alloc] init];
        for (int i = 0; i < 10; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_to_refresh_%d_54x54_",i+1]];
            [_pullingImages addObject:image];
        }
        
    }
    return _pullingImages;
}
//正在刷新状态下的图片
- (NSMutableArray *)refreshImages
{
    if (_refreshImages == nil) {
        _refreshImages = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 10; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"pull_to_refresh_%d_54x54_",i+1]];
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
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f8"];
    //去除footer样式
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    //设置网络数据下啦刷新
    __weak typeof(self) weakSelf = self;
   MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
      
           [weakSelf.tableView.mj_header endRefreshing];
       
    }];
    [header setImages:self.normalImages forState:MJRefreshStateIdle];
    [header setImages:self.pullingImages  forState:MJRefreshStatePulling];
    [header setImages:self.refreshImages  forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    self.tableView.mj_header.mj_h = 74;
    
    //设置上拉加载更多数据
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [weakSelf.tableView.mj_footer endRefreshing];
        
    }];
    self.tableView.mj_footer = footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
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
