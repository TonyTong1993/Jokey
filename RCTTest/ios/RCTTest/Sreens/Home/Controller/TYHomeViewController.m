//
//  TYHomeViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYHomeViewController.h"
#import "TYNetWorkingTool.h"
#import "MJCSegmentInterface.h"
@interface TYHomeViewController ()

@end

@implementation TYHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        [dataSource addObject:@""];
       
       
    }
    self.dataSource = dataSource;
   
    UIViewController *vc1 = [[UIViewController alloc]init];
//    vc1.titlesCount = 1;
    UIViewController *vc2 = [[UIViewController alloc]init];
//    vc2.titlesCount = 2;
//    MJCTestViewController1 *vc3 = [[MJCTestViewController1 alloc]init];
//    vc3.titlesCount = 3;
//    MJCTestViewController *vc4 = [[MJCTestViewController alloc]init];
//    vc4.titlesCount = 4;
//    MJCTestViewController *vc5 = [[MJCTestViewController alloc]init];
//    vc5.titlesCount = 5;
//    MJCTestViewController *vc6 = [[MJCTestViewController alloc]init];
//    vc6.titlesCount = 6;
//    MJCTestViewController *vc7 = [[MJCTestViewController alloc]init];
//    vc7.titlesCount = 7;
    NSArray *vcarrr = @[vc1,vc2];
    NSArray *titlesArr = @[@"荣耀",@"联盟"];
    
    //以下是我的控件中的代码
    MJCSegmentInterface *lala = [[MJCSegmentInterface alloc]init];
    lala.frame = CGRectMake(0,64,self.view.mj_w, self.view.mj_h-64);
    lala.selectedSegmentIndex = 1;
    [lala intoTitlesArray:titlesArr hostController:self];
    [self.view addSubview:lala];
    [lala intoChildControllerArray:vcarrr];
}

-(void)setUpTableView {
    [super setUpTableView];
    MJCSegmentInterface *segmentInterface = [MJCSegmentInterface segmentinitWithFrame:CGRectMake(0, 0, self.view.mj_w, 44) MJCTitleBarStyle:<#(MJCTitleBarStyles)#>]
    
}

@end
