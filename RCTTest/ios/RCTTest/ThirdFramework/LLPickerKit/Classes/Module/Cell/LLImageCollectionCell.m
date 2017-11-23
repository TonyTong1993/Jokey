//
//  LLImageCollectionCell.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/16.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLImageCollectionCell.h"
#import "LLSelectButton.h"
#import "Config.h"

static CGFloat const kPadding = 3.f;
#define kImageCollectionCellWidth (kScreenWidth - 5 * kPadding) / 4

@interface LLImageCollectionCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) LLSelectButton *selectButton;
@property (nonatomic, strong) ALAsset *alAsset;
@property (nonatomic, strong) PHAsset *phAsset;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) LLImageCollectionCellBlock selectedBlock;

@end

@implementation LLImageCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.index = 0;
        [self buildingUI];
        [self layoutUI];
    }
    return self;
}

- (void)buildingUI {
    self.imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.backgroundColor = kPlaceholderImageColor;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    self.selectButton = [LLSelectButton building];
    [self addSubview:_selectButton];
    
    WeakSelf(self)
    [_selectButton handleSelectButtonEventWithBlock:^(LLSelectButton *sender, BOOL isSelected) {
        if ([[LLImageSelectHandler instance] selectedAssets].count >= [[LLImageSelectHandler instance] maxSelectedCount] && isSelected) {
            [LLMessageDialog showMessageDialog:kPhotosNumberReachedMaxValue];
            sender.selected = NO;
            return;
        }
        if (isSelected) {
            [[LLImageSelectHandler instance] addAsset:(iOS8Upwards ? weakSelf.phAsset : weakSelf.alAsset)];
            [Utils addScaleAnimation:sender];
            Block_exe(weakSelf.selectedBlock, weakSelf.index);
        } else {
            [[LLImageSelectHandler instance] removeAsset:(iOS8Upwards ? weakSelf.phAsset : weakSelf.alAsset)];
        }
    }];
}

- (void)layoutUI {
    WeakSelf(self)
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.with.right.equalTo(weakSelf);
    }];
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(weakSelf.mas_right).offset(-2);
        make.top.equalTo(weakSelf.mas_top).offset(2);
    }];
}

- (void)reloadDataWithALAsset:(ALAsset *)asset index:(NSInteger)index {
    self.index = index;
    self.alAsset = asset;
    self.imageView.image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
}

- (void)reloadDataWithPHAsset:(PHAsset *)asset index:(NSInteger)index {
    self.index = index;
    self.phAsset = asset;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        WeakSelf(self)
        [self.phAsset thumbnail:CGSizeMake(kImageCollectionCellWidth, kImageCollectionCellWidth) resultHandler:^(UIImage *result, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.imageView.image = result;
            });
        }];
    });
}

- (void)getSelectedIndexWithBlock:(LLImageCollectionCellBlock)block {
    self.selectedBlock = block;
}

- (void)resetSelected:(BOOL)selected {
    self.selectButton.selected = selected;
}

@end
