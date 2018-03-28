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
@interface TYProfileViewController ()
{
    NSTimeInterval time;
}
@end

@implementation TYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    //添加测试数据
    NSDictionary *jsonDict = [NSBundle loadJsonFromBundle:@"Profile"];
    self.dataSource = [TYProfileViewModel mj_objectArrayWithKeyValuesArray:jsonDict[@"data"]];
    
  NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(scheduledTimer) userInfo:nil repeats:false];
  [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    time = 0;
    [timer fire];

}

-(void)scheduledTimer {
  
   TYProfileViewModel *model = [[self.dataSource firstObject] firstObject];
   NSString *title = [NSString stringWithFormat:@"-----%lf",time++];
    model.title = title;
    NSLog(@"%@",[NSThread currentThread]);
//   NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    });
}

-(void)setUpTableView {
    [super setUpTableView];
    
    [self.tableView.mj_header removeFromSuperview];
    self.tableView.mj_header = nil;
    [self.tableView.mj_footer removeFromSuperview];
    self.tableView.mj_footer = nil;
    self.tableView.backgroundColor = HEXCOLOR(backgroundColorHexValue);
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
//         NSURL *jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
        NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
        RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"test" initialProperties:@{} launchOptions:nil];
        TYShopViewController *vc = [[TYShopViewController alloc] init];
        vc.view = rootView;
        VC = vc;
    }else if ([model.className isEqualToString:@"TYRunViewController"]) {
        VC = [[TYRunViewController alloc] init];
    }else {
        VC = [[UIViewController alloc] init];
    }
    [self.navigationController pushViewController:VC animated:YES];
    
}
@end
