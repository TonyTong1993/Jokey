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
#import "TYRecommendViewController.h"
@interface TYHomeViewController ()<TYSegmentControlDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) TYSegmentView *segmentView;
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
    self.segmentView = segmentView;
    [self setUpTableView];
    [self loadNewData];
    
    
    TBCityIconInfo *iconInfo = TBCityIconInfoMake(@"\U0000e6df", 24, [UIColor randomColor]);
    UIImage *image = [UIImage iconWithInfo:iconInfo];
    
    UIBarButtonItem *rightBtn = [UIBarButtonItem barBtnItemWithNormalIcon:image highlightIcon:image target:self action:@selector(handleClick)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}
-(void)setUpTableView {
    self.automaticallyAdjustsScrollViewInsets = false;
    
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height-64-49;
    //设置scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = false;
    self.scrollView.showsHorizontalScrollIndicator = false;
    self.scrollView.delegate = self;
    self.scrollView.bounces = false;
    [self.view addSubview:_scrollView];
    
    for (int i  = 0; i < 3; i++) {
        TYRecommendViewController *vc = [[TYRecommendViewController alloc] init];
        [self addChildViewController:vc];
    }
    CGFloat startX = 0;
    CGFloat startY = 0;
    NSUInteger index = 0;
    NSUInteger count = self.childViewControllers.count;
    self.scrollView.contentSize = CGSizeMake(width*count, height);
    for (UIViewController *viewController in self.childViewControllers) {
        startX = index*width;
        UIView *view =  viewController.view;
        view.frame = CGRectMake(startX, startY, width, height);
        [self.scrollView addSubview:view];
        index++;
    }
}

#pragma mark---
#pragma mark--- TYSegmentControlDelegate
-(void)segmentConrol:(UIView *)segmentView didSelectedItemAtIndex:(NSUInteger)index {
      CGFloat width = self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(width*index, 0) animated:false];
}
#pragma mark---
#pragma mark---UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
   
    [self.segmentView setIndicatorViewScrollOffSetX:scrollView];
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    [_segmentView segment_resetItemTextNormalColors];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
     [_segmentView segment_resetItemTextNormalColors];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.segmentView updateSelectedItemIndex:index];
    
}
@end
