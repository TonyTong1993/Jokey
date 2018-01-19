//
//  TYRecommendViewController.m
//  RCTTest
//
//  Created by 童万华 on 2017/8/9.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYRecommendViewController.h"
#import "TYStatusViewCell.h"
#import "TYFPSLabel.h"
#import "Test.h"
#import "TYHomeUitl.h"
#import "TYCalculateFrameTool.h"
#import "TYTestViewController.h"

static NSString *reuserIndentifier = @"KTYStatusViewCell";
@interface TYRecommendViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) TYFPSLabel *fpsLabel;
@end

@implementation TYRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    
    _fpsLabel = [TYFPSLabel new];
    [_fpsLabel sizeToFit];
    _fpsLabel.bottom = self.view.height - kWBCellPadding;
    _fpsLabel.left = kWBCellPadding;
    _fpsLabel.alpha = 0.0f;
    [self.view addSubview:_fpsLabel];
    
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
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:NULL];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (_fpsLabel.alpha != 0) {
            [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                _fpsLabel.alpha = 0;
            } completion:NULL];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha != 0) {
        [UIView animateWithDuration:1 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 0;
        } completion:NULL];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if (_fpsLabel.alpha == 0) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _fpsLabel.alpha = 1;
        } completion:^(BOOL finished) {
        }];
    }
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
