//
//  TYOCTestListViewController.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/14.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYOCTestListViewController.h"
#import <YYKit/NSBundle+YYAdd.h>
#import <YYKit/NSObject+YYModel.h>
@interface TestItem : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *className;
@end
@implementation TestItem

@end

@interface TYOCTestListViewController ()
@property (nonatomic,copy) NSArray *dataSource;
@end
static NSString *reuseIdentifier = @"cell";
@implementation TYOCTestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"laboratoryList" ofType:@"plist"];
    NSArray *data = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *dataSource = [NSMutableArray array];
    for (NSDictionary *dict in data) {
        TestItem *item = [TestItem modelWithJSON:dict];
        [dataSource addObject:item];
    }
    self.dataSource = dataSource;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    TestItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.title;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     TestItem *item = self.dataSource[indexPath.row];
    UIViewController *vc =  [[NSClassFromString(item.className) alloc] init];
    vc.view.backgroundColor = [UIColor randomColor];
    [self.navigationController pushViewController:vc animated:YES];
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
