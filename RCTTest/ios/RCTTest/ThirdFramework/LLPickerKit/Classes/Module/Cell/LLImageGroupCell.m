//
//  LLImageGroupCell.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLImageGroupCell.h"
#import "Config.h"

static CGFloat const kGroupCellHeight = 60;

@interface LLImageGroupCell ()

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UILabel *groupNameLabel;
@property (nonatomic, strong) UILabel *photoNumberLabel;

@end

@implementation LLImageGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self buildingUI];
        [self layoutUI];
    }
    return self;
}

- (void)reloadDataWithAssetsGroup:(ALAssetsGroup *)assetsGroup {
    UIImage *image = [[UIImage alloc] initWithCGImage:[assetsGroup posterImage]];
    NSString *groupName = [assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    NSString *numberOfAssets = Format(@"(%zd)", [assetsGroup numberOfAssets]);
    self.thumbnailImageView.image = image;
    self.groupNameLabel.text = [Utils replaceEnglishAssetCollectionNamme:groupName];
    self.photoNumberLabel.text = numberOfAssets;
}

- (void)reloadDataWithAssetCollection:(PHAssetCollection *)assetCollection {
    NSString *groupName = assetCollection.localizedTitle;
    NSString *numberOfAssets = Format(@"(%zd)", [assetCollection numberOfAssets]);
    self.groupNameLabel.text = [Utils replaceEnglishAssetCollectionNamme:groupName];
    self.photoNumberLabel.text = numberOfAssets;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        WeakSelf(self)
        [assetCollection posterImage:CGSizeMake(kGroupCellHeight, kGroupCellHeight) resultHandler:^(UIImage *result, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.thumbnailImageView.image = result;                
            });
        }];
    });
}

+ (CGFloat)height {
    return kGroupCellHeight;
}

#pragma mark -
#pragma mark - privite methods
- (void)buildingUI {
    self.thumbnailImageView = [[UIImageView alloc] init];
    _thumbnailImageView.backgroundColor = kPlaceholderImageColor;
    _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
    _thumbnailImageView.clipsToBounds = YES;
    [self addSubview:_thumbnailImageView];
    
    self.groupNameLabel = [Utils building:1 textColor:[UIColor blackColor] textAligment:0 font:BoldFont(17) superview:self];
    self.photoNumberLabel = [Utils building:1 textColor:HEXCOLOR(0x7d7d7d) textAligment:0 font:Font(17) superview:self];
}

- (void)layoutUI {
    WeakSelf(self)
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kGroupCellHeight, kGroupCellHeight));
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.groupNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.thumbnailImageView.mas_right).offset(10);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.photoNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.groupNameLabel.mas_right).offset(15);
        make.centerY.equalTo(weakSelf);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
