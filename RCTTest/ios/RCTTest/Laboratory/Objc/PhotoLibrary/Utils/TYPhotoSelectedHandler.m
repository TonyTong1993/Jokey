//
//  TYPhotoSelectedHandler.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/12.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYPhotoSelectedHandler.h"

@implementation TYPhotoSelectedHandler
SINGLETON_FOR_CLASS(TYPhotoSelectedHandler)
-(NSMutableArray *)selectedPhotos {
    if (!_selectedPhotos) {
        _selectedPhotos = [NSMutableArray arrayWithCapacity:9];
    }
    return _selectedPhotos;
}
@end
