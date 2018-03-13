//
//  TYPhotoSelectedHandler.h
//  RCTTest
//
//  Created by 童万华 on 2018/3/12.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYPhotoSelectedHandler : NSObject
SINGLETON_FOR_HEADER(TYPhotoSelectedHandler)
@property (nonatomic,strong) NSMutableArray *selectedPhotos;
@property (nonatomic,assign) NSUInteger maxSelectedCount;
@end
