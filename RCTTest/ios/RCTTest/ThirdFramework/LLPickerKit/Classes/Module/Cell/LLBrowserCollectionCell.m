//
//  LLBrowserCollectionCell.m
//  LLImagePickerController
//
//  Created by 雷亮 on 16/8/17.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "LLBrowserCollectionCell.h"
//#import "LLBrowserScrollView.h"
//#import <SDWebImageDownloaderOperation.h>
@interface LLBrowserCollectionCell ()

//@property (nonatomic, strong) LLBrowserScrollView *scrollView;
@property (nonatomic, strong) ALAsset *alAsset;
@property (nonatomic, strong) PHAsset *phAsset;

@end

@implementation LLBrowserCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        self.scrollView = [[LLBrowserScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
//        [self addSubview:_scrollView];
//        
//        _scrollView.zoomScale = 1.f;
//        _scrollView.contentSize = _scrollView.size;
    }
    return self;
}
//
//- (void)handleSingleTapActionWithBlock:(dispatch_block_t)block {
//    [_scrollView handleSingleTapActionWithBlock:block];
//}
//-(void)handleLongTapActionWithBlock:(dispatch_block_t)block {
//     [_scrollView handleLongTapActionWithBlock:block];
//}
//- (void)reloadDataWithALAsset:(ALAsset *)asset {
//    self.alAsset = asset;
//    _scrollView.image = [asset fullScreenImage];
//}
//-(void)reloadDataWithImage:(UIImage *)image {
//    _scrollView.image = image;
//}
//-(void)reloadDataWithImageURL:(NSString *)imageURL{
//
//  [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:imageURL] options:SDImageCacheTypeDisk|SDImageCacheTypeMemory progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//       float progress = receivedSize/(float)expectedSize;
//       DLog(@"progress---%f",progress);
//  } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//      [SVProgressHUD dismissWithDelay:0.5];
//      if (!error) {
//           _scrollView.image = image;
//          
//      }else {
//          [self.superview makeToast:@"网络请求超时" iconName:nil];
//      }
//  }];
//}
//-(void)reloadDataWithImageURL:(NSString *)imageURL withThumbnailURL:(NSString *)thumbnailURL {
//   UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailURL];
//   UIImage *placeholder = image?image:[UIImage imageNamed:@"placeholder"];
//    _scrollView.image = placeholder;
//    [self reloadDataWithImageURL:imageURL];
//}
//- (void)reloadDataWithPHAsset:(PHAsset *)asset {
//    self.phAsset = asset;
//    _scrollView.zoomScale = 1.f;
//    _scrollView.contentSize = _scrollView.size;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        [asset requestImageForTargetSize:[UIScreen mainScreen].bounds.size resultHandler:^(UIImage *result, NSDictionary *info) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                _scrollView.image = result;
//            });
//        }];
//    });
//}

@end
