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
    
    self.tableView.backgroundColor = HEXCOLOR(backgroundColorHexValue);
    self.tableView.separatorColor = HEXCOLOR(separatorColorHexValue);
    //去除footer样式
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
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
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorColor:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
@end
