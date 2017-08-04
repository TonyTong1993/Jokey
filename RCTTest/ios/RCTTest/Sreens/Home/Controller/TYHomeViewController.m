//
//  TYHomeViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/6/28.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYHomeViewController.h"
#import "TYNetWorkingTool.h"
#import "TYSegmentView.h"
@interface TYHomeViewController ()<TYSegmentControlDelegate>

@end

@implementation TYHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        [dataSource addObject:@""];
       
       
    }
    self.dataSource = dataSource;
    NSArray *titles = @[@"推荐",@"视频",@"图文"];
    TYSegmentView *segmentView = [[TYSegmentView alloc] initWithTitles:titles];
    
    [segmentView setTitleFont:[UIFont fontWithName:[TYTheme themeFontFamilyName] size:16]];
    [segmentView setTitleColor:HEXCOLOR(0x333333) state:SegmentControlStateNormal];
    [segmentView setTitleColor:HEXCOLOR(0x55B1E6) state:SegmentControlStateSelected];
    segmentView.delegate = self;
    [segmentView setSelectedItemIndex:0];
    [segmentView setIndicatorBackgroundColor:HEXCOLOR(0x55B1E6)];
    self.navigationItem.titleView = segmentView;
}

-(void)setUpTableView {
    [super setUpTableView];
  
}

#pragma mark---
#pragma mark--- TYSegmentControlDelegate
-(void)segmentConrol:(UIView *)segmentView didSelectedItemAtIndex:(NSUInteger)index {
    NSLog(@"didSelectedItemAtIndex = %lu",index);
}
@end
