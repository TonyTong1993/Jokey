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
#import "TYProfileViewModel.h"
#import "TYRunViewController.h"
#import <CodePush/CodePush.h>
@interface TYProfileViewController ()

@end

@implementation TYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    //添加测试数据
    NSDictionary *jsonDict = [NSBundle loadJsonFromBundle:@"Profile"];
    self.dataSource = [TYProfileViewModel mj_objectArrayWithKeyValuesArray:jsonDict[@"data"]];
}

-(void)setUpTableView {
    [super setUpTableView];
    
    [self.tableView.mj_header removeFromSuperview];
    self.tableView.mj_header = nil;
    [self.tableView.mj_footer removeFromSuperview];
    self.tableView.mj_footer = nil;
    self.tableView.backgroundColor = HEXCOLOR(0xf5f5f5);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray *)self.dataSource[section]).count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuserIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndentifier];
    }
    TYProfileViewModel *model = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = model.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = section ? [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)] : nil;
    header.backgroundColor = [UIColor clearColor];
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section ? 20 : 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     TYProfileViewModel *model = self.dataSource[indexPath.section][indexPath.row];
    UIViewController *VC;
    if ([model.className isEqualToString:@"TYShopViewController"]) {
        NSURL *jsCodeLocation;
#ifdef DEBUG
       jsCodeLocation = [NSURL URLWithString:@"http://192.168.10.50:8081/index.ios.bundle?platform=ios"];
        
#else
        jsCodeLocation = [CodePush bundleURL];
#endif
        RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"test" initialProperties:@{} launchOptions:nil];
        TYShopViewController *vc = [[TYShopViewController alloc] init];
        vc.view = rootView;
        VC = vc;
    }else if ([model.className isEqualToString:@"TYRunViewController"]) {
        VC = [[TYRunViewController alloc] init];
    }else {
#if !TARGET_IPHONE_SIMULATOR
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"19011100528" conversationType:EMConversationTypeChat];
        VC = chatController;
#else
        UIViewController *chatController = [[UIViewController alloc] init];
        VC = chatController;
#endif
    }
    [self.navigationController pushViewController:VC animated:YES];
    
}
@end
