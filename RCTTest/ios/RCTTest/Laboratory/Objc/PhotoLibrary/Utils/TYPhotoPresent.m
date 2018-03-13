//
//  TYPhotoPresent.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/8.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoPresent.h"
typedef void (^ComplicationHanlder)(NSMutableArray *results);
@interface TYPhotoPresent()<PHPhotoLibraryChangeObserver>
@property (nonatomic,copy) ComplicationHanlder handler;
@end
@implementation TYPhotoPresent
-(instancetype)init {
    self = [super init];
    if (self) {
         [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    }
    return self;
}

-(instancetype)initWithPresenter:(UIViewController *)presenter {
    self = [self init];
    if (self) {
        self.viewController = presenter;
    }
    return self;
}

-(void)requestAuthorization:(void (^)(NSMutableArray *result))hanlder  {
     self.handler = hanlder;
        [TYPhotoHandler requestAuthorization:^(TYAuthorizationStatus status) {
            switch (status) {
                case TYAuthorizationStatusDenied:
                case TYAuthorizationStatusRestricted:
                {
                    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"监测到您未开启相册权限，去开启吧！" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    UIAlertAction *authorizedAction = [UIAlertAction actionWithTitle:@"Go" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        
                        if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                            NSURL *openURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                            NSDictionary *option = @{};
                            [[UIApplication sharedApplication] openURL:openURL options:option completionHandler:^(BOOL success) {
                                
                            }];
                        }
                        
                    }];
                    [alertVC addAction:cancelAction];
                    [alertVC addAction:authorizedAction];
                    [self.viewController presentViewController:alertVC animated:YES completion:nil];
                }
                    break;
                case TYAuthorizationStatusAuthorized:
                case TYAuthorizationStatusNotDetermined:
                    
                    [TYPhotoHandler enumeratePHAssetCollectionsWithResultHandler:^(NSArray<PHAssetCollection *> *result) {
                        if (result.count == 0) return;
                            if (self.handler) {
                                self.handler((NSMutableArray *)result);
                            }
                    }];
                    break;
            }
        }];

}
-(void)requestAllPhAssets:(void(^)(PHFetchResult <PHAsset *>*result))finishBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [TYPhotoHandler enumerateAllAssetsInCollectionsWithfinishBlock:^(PHFetchResult<PHAsset *> *result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finishBlock(result);
            });
        }];
    });
   
}

-(void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}
#pragma mark--PHPhotoLibraryChangeObserver
-(void)photoLibraryDidChange:(PHChange *)changeInstance {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [TYPhotoHandler enumeratePHAssetCollectionsWithResultHandler:^(NSArray<PHAssetCollection *> *result) {
             if (result.count == 0) return;
                if (self.handler) {
                    self.handler((NSMutableArray *)result);
                }
        }];
    });
    
}
@end
