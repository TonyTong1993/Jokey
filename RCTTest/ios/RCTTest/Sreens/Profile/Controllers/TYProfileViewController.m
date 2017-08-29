//
//  TYProfileViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYProfileViewController.h"
#import "NSBundle+Extension.h"
#import <React/RCTRootView.h>
#import "TYShopViewController.h"
@interface TYProfileViewController ()

@end

@implementation TYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加测试数据
    NSDictionary *jsonDict = [NSBundle loadJsonFromBundle:@"Profile"];
    self.dataSource = jsonDict[@"data"];
}

-(void)setUpTableView {
    [super setUpTableView];
    
    [self.tableView.mj_header removeFromSuperview];
    self.tableView.mj_header = nil;
    [self.tableView.mj_footer removeFromSuperview];
    self.tableView.mj_footer = nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuserIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://192.168.10.40:8081/index.ios.bundle?platform=ios"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"test" initialProperties:@{} launchOptions:nil];
    TYShopViewController *vc = [[TYShopViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:true completion:^{
        
    }];
    
    
}
@end
