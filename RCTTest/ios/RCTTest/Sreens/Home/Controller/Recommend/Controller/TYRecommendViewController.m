//
//  TYRecommendViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/9.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYRecommendViewController.h"
#import "Test.h"
@interface TYRecommendViewController ()

@end

@implementation TYRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)setUpTableView {
    [super setUpTableView];
}

@end

@implementation TYRecommendViewController (service)

-(void)loadNewData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recommend" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *dataDict = dict[@"data"];
    NSMutableArray *dataSource = [TYModelTest mj_objectArrayWithKeyValuesArray:dataDict[@"list"]];
    self.dataSource = dataSource;
}

@end
