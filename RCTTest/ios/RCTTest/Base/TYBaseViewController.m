//
//  TYBaseViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/7/12.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYBaseViewController.h"
#import "UIImage+Extentions.h"
#import "UIScrollView+Refresh.h"
@interface TYBaseViewController ()

@end

@implementation TYBaseViewController
#pragma mark---getter and setter

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpNavigationBar];
    self.dataSource = @[];
}

-(void)setUpTableView {
    CGRect frame = self.view.bounds;
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
<<<<<<< HEAD
   
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 125, 0);
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f8"];
    self.tableView.separatorColor = HEXCOLOR(0xebebeb);
=======
    
    self.tableView.backgroundColor = HEXCOLOR(backgroundColorHexValue);
    self.tableView.separatorColor = HEXCOLOR(separatorColorHexValue);
>>>>>>> origin/dev
    //去除footer样式
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
<<<<<<< HEAD
    //设置网络数据下啦刷新
    __weak typeof(self) weakSelf = self;
   MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
      
           [weakSelf loadNewData];
       
    }];
    [header setImages:self.normalImages forState:MJRefreshStateIdle];
    [header setImages:self.pullingImages  forState:MJRefreshStatePulling];
    [header setImages:self.refreshImages  forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    header.stateLabel.hidden = YES;
    self.tableView.mj_header = header;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 12, 0, 12);
    //设置上拉加载更多数据
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        [weakSelf loadMoreData];
        
    }];
    self.tableView.mj_footer = footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;
    
    
    //ios11 适配
    if (@available(iOS 11.0,*)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 125, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
        
#pragma mark--在iOS 11中默认启用Self-Sizing 关闭方法
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        
    }
=======
    CGFloat bottomOffset = 0.0f;
    if (@available(iOS 11, *)) {
         //关闭Self-Sizing
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        bottomOffset = is_iPhoneX?83.0f:64.0f;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
        bottomOffset = 64.0f;
    }
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomOffset, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
>>>>>>> origin/dev
}

-(void)setUpNavigationBar {
    
}

//RTRootNavigationController中扩展的方法
- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target
                                          action:(SEL)action
{
    
    UIImage *image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e720;",24, HEXCOLOR(textTint))];
    return  [UIBarButtonItem barBtnItemWithNormalIcon:image
                                        highlightIcon:image
                                               target: target
                                               action:action];
    
    
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
