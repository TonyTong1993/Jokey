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
#import "TYSegmentViewController.h"
@interface TYHomeViewController ()<TYSegmentControlDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation TYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.automaticallyAdjustsScrollViewInsets = false;
    //设置scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.delegate = self;
    self.scrollView.bounces = false;
    [self.view addSubview:_scrollView];
    
    for (int i  = 0; i < 3; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        [self addChildViewController:vc];
    }
    
    
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    CGFloat startX = 0;
    CGFloat startY = 0;
    NSUInteger index = 0;
    NSUInteger count = self.childViewControllers.count;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    for (UIViewController *viewController in self.childViewControllers) {
        startX = index*width;
        UIView *view =  viewController.view;
        view.frame = CGRectMake(startX, startY, width, height);
        view.backgroundColor = [UIColor randomColor];
        [self.scrollView addSubview:view];
        index++;
    }
}
#pragma mark---
#pragma mark--- TYSegmentControlDelegate
-(void)segmentConrol:(UIView *)segmentView didSelectedItemAtIndex:(NSUInteger)index {
    NSLog(@"didSelectedItemAtIndex = %lu",index);
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetX = scrollView.contentOffset.x;
//    CGFloat width = self.view.frame.size.width;
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    NSLog(@"scrollViewDidEndDragging");
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"scrollViewWillEndDragging");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     NSLog(@"scrollViewDidEndDecelerating");
}
@end
