//
//  TYStatusViewCell.m
//  RCTTest
//
//  Created by 童万华 on 17/8/9.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYStatusViewCell.h"
#import "TYServiceApi.h"
#import "TYModelTest.h"
#import "TYMemberTest.h"
#import "TYImageTest.h"
#import "TYHomeUitl.h"
#import "TYImageViewCell.h"
#import "TestView.h"
#import "TYStatusCommentView.h"
static NSString *reuseIndentifier = @"KTYImageViewCell";
@interface TYStatusViewCell()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;
@property (weak, nonatomic) IBOutlet UIButton *upBtn;
@property (weak, nonatomic) IBOutlet UIButton *downBtn;
@property (weak, nonatomic) IBOutlet UILabel *numberOfUp;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
@implementation TYStatusViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatarView.layer.cornerRadius = _avatarView.mj_w/2;
    self.avatarView.layer.masksToBounds = YES;
    self.shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    self.reviewBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    self.topicLabel.backgroundColor = HEXCOLOR(0x39B4FF);
    self.topicLabel.layer.cornerRadius = 2;
    self.topicLabel.layer.masksToBounds = true;
    [self.pageControl setCurrentPageIndicatorTintColor:HEXCOLOR(0x39B4FF)];
    [self.pageControl setPageIndicatorTintColor:HEXCOLOR(0xDBDBDB)];
    self.translatesAutoresizingMaskIntoConstraints = false;
    
    //注册xib
    [self.collectionView registerNib:[UINib nibWithNibName:@"TYImageViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIndentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    //设置scrollView
    self.scrollView.delegate = self;
    
    //FIXME:需要根据模型确定高度
    if (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_10_0) [_scrollView layoutIfNeeded];
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3,  _scrollView.mj_h);
    int index = 0;
    for (int i = 0; i < 3; i++) {
        TYStatusCommentView *view = [[TYStatusCommentView alloc] initWithFrame: CGRectMake(SCREEN_WIDTH*index, 0, SCREEN_WIDTH,  _scrollView.mj_h)];
            index++;
        
        [self.scrollView addSubview:view];
    }
}

-(void)setModel:(TYModelTest *)model {
    _model = model;
    TYMemberTest *member = [TYMemberTest mj_objectWithKeyValues:model.member];
    NSString *avatarPath = [TYServiceApi serviceForImagePath:api_common_avatar imageID:member.avatar size:228];
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:avatarPath]];
    _nameLabel.text = member.name;
    _contentLabel.text = model.content;
    CGFloat collectionViewheight = [TYHomeUitl homeUitlGetCollectionViewHeight:model.imgs.count];
    self.collectionViewHeightConstraint.constant = collectionViewheight;
    [self.collectionView reloadData];
}
-(void)layoutSubviews {
    [super layoutSubviews];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.imgs.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    TYImageViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIndentifier forIndexPath:indexPath];
    NSDictionary *imageDic = self.model.imgs[indexPath.item];
    TYImageTest *imageModel = [TYImageTest mj_objectWithKeyValues:imageDic];
    NSString *imagePath = [TYServiceApi serviceForImagePath:api_common_image imageID:imageModel.imageID size:228];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.collectionView.mj_w;
    CGFloat margin = 4;
    int itemCount = [[NSString stringWithFormat:@"%lu",(unsigned long) _model.imgs.count] intValue];
    int row = floorf(itemCount/3.0)?3:itemCount;
    int itemW = (width-margin*(row-1))/row;
    return CGSizeMake(itemW, itemW);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
   
}
@end


