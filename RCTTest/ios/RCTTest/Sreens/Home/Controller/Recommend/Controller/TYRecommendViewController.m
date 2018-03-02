//
//  TYRecommendViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/9.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYRecommendViewController.h"
#import "TYStatusViewCell.h"
#import "Test.h"
#import "TYHomeUitl.h"
#import "TYCalculateFrameTool.h"
#import "TYTestViewController.h"
#import "UIScrollView+Refresh.h"
static NSString *reuserIndentifier = @"KTYStatusViewCell";
@interface TYRecommendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation TYRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    self.navigationController.view.backgroundColor = [UIColor randomColor];
}
-(void)setUpTableView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 70, 0);
    _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
    [self.view addSubview:_collectionView];
    
    //设置网络数据下啦刷新
    __weak typeof(self) weakSelf = self;
    self.collectionView.backgroundColor = HEXCOLOR(0xEFF0F6);
    
    [self.collectionView addHeaderRefreshWithBlock:^{
        [weakSelf loadNewData];
    }];
    
    //设置上拉加载更多数据
    
    [self.collectionView addFooterRefreshWithBlock:^{
        [weakSelf loadMoreData];
    }];

    [self.collectionView registerNib:[UINib nibWithNibName:@"TYStatusViewCell" bundle:nil] forCellWithReuseIdentifier:reuserIndentifier];
    
    [self.collectionView.mj_header beginRefreshing];
    
    
}


#pragma mark---
#pragma mark---UICollectionViewDataSource and UICollectionViewDelegate and UICollectionViewDelegateFlowLayout
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TYStatusViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserIndentifier forIndexPath:indexPath];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(TYStatusViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
     TYModelTest *model = self.dataSource[indexPath.item];
    cell.model = model;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TYModelTest *model = self.dataSource[indexPath.item];
    CGFloat headerHeight = 70.0f;
    CGFloat footerHeight = 50.0f;
    CGFloat contentH = [TYCalculateFrameTool frameWithContent:model.content font:[UIFont systemFontOfSize:16] preferredMaxLayoutWidth:SCREEN_WIDTH-28].height;
    CGFloat marginBetweenContentAndCollectionView = 20;
    CGFloat collectionViewheight = [TYHomeUitl homeUitlGetCollectionViewHeight:model.imgs.count];
    CGFloat marginBetweenScrollViewAndCollectionView = 24;
    CGFloat scrollViewheight = 96;
    CGFloat width = SCREEN_WIDTH ;
    CGFloat height = headerHeight + footerHeight + collectionViewheight + scrollViewheight + marginBetweenContentAndCollectionView + marginBetweenScrollViewAndCollectionView + contentH;
    return CGSizeMake(width, height);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TYTestViewController *testVC = [[TYTestViewController alloc] init];
    testVC.title = @"实践渐变颜色";
    [self.navigationController pushViewController:testVC animated:YES];
}
@end

@implementation TYRecommendViewController (service)

-(void)loadNewData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"recommend" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *dataDict = dict[@"data"];
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
         NSMutableArray *datas = [TYModelTest mj_objectArrayWithKeyValuesArray:dataDict[@"list"]];
        [dataSource addObjectsFromArray:datas];
    }
    self.dataSource = dataSource;
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView reloadData];
}
-(void)loadMoreData {
     [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}
@end
