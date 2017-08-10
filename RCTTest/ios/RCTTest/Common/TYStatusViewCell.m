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
@interface TYStatusViewCell()
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

@end
@implementation TYStatusViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatarView.layer.cornerRadius = 30;
    self.avatarView.layer.masksToBounds = YES;
}

-(void)setModel:(TYModelTest *)model {
    _model = model;
    TYMemberTest *member = [TYMemberTest mj_objectWithKeyValues:model.member];
    NSString *avatarPath = [TYServiceApi serviceForImagePath:api_common_avatar imageID:member.avatar];
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:avatarPath] placeholderImage:[UIImage imageNamed:@"header_placeholder"]];
    _nameLabel.text = member.name;
    _contentLabel.text = model.content;
    
}

@end

@implementation TYStatusViewCell (colectionView)
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
@end

@implementation TYStatusViewCell (scrollView)

@end
