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
static NSString *reuserIndentifier = @"KTYStatusViewCell";
@interface TYRecommendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation TYRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
}
-(void)setUpTableView {
    self.automaticallyAdjustsScrollViewInsets = false;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height-103;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height) collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    //设置网络数据下啦刷新
    __weak typeof(self) weakSelf = self;
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        [weakSelf loadNewData];
        
    }];
    self.collectionView.backgroundColor = HEXCOLOR(0xEFF0F6);
    [header setImages:self.normalImages forState:MJRefreshStateIdle];
    [header setImages:self.pullingImages  forState:MJRefreshStatePulling];
    [header setImages:self.refreshImages  forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    self.collectionView.mj_header.mj_h = 74;
    
    //设置上拉加载更多数据
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf loadMoreData];
        
    }];
    self.collectionView.mj_footer = footer;
    footer.refreshingTitleHidden = YES;
    footer.stateLabel.hidden = YES;

    
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
    NSMutableArray *dataSource = [TYModelTest mj_objectArrayWithKeyValuesArray:dataDict[@"list"]];
    self.dataSource = dataSource;
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView reloadData];
}
-(void)loadMoreData {
     [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}
@end
