//
//  PHAsset+Image.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/9.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <Photos/Photos.h>

@interface PHAsset (Image)
-(void)requestThumbnailWithTargetSize:(CGSize)targetSize
                  complicationhandler:(void (^)(UIImage *result, NSDictionary *))resultHandler;
@end
