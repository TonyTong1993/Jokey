//
//  TYTestViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/23.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYTestViewController.h"
#import "TYTestSecondViewController.h"
@interface TYTestViewController ()

@end

@implementation TYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 74, 25)];
//    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [leftBtn setTitle:@"已认证" forState:UIControlStateNormal];
//    [leftBtn setTitleColor:HEXCOLOR(0xffffff) forState:UIControlStateNormal];
//    [self.view addSubview:leftBtn];
//
//    /*背景渐变*/
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//
//    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"#2cda89"].CGColor,
//                             (__bridge id)[UIColor colorWithHexString:@"#0dc870"].CGColor,];
//    gradientLayer.locations = @[@0.2, @1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 0);
//    gradientLayer.frame = leftBtn.bounds;
//    [leftBtn.layer addSublayer:gradientLayer];
//    [leftBtn.layer insertSublayer:gradientLayer atIndex:0];
//    leftBtn.layer.cornerRadius = 12.5;
//    leftBtn.layer.masksToBounds = YES;
    [self setUpTableView];
    self.dataSource = @[
                        @"测试数据----001",
                        @"测试数据----002",
                        @"测试数据----003",
                        @"测试数据----004",
                        @"测试数据----005",
                        @"测试数据----006",
                        @"测试数据----007",
                        @"测试数据----008",
                        ];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

-(void)setUpTableView {
    [super setUpTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIndentifier = @"dequeueCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
    }
    NSString *title = self.dataSource[indexPath.row];
    cell.textLabel.text = title;
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TYTestSecondViewController *secondVC = [[TYTestSecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}
@end
