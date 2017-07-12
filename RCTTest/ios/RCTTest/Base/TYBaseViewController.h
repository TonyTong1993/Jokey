//
//  TYBaseViewController.h
//  RCTTest
//
//  Created by 童万华 on 2017/7/12.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TYBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,copy) NSArray *dataSource;

-(void)setUpTableView ;//设置表格视图

-(void)setUpNavigationBar ;//设置导航栏

-(void)loadNewData;//加载新数据

-(void)loadMoreData;//加载更多数据
@end
