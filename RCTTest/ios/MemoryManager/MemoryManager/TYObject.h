//
//  TYObject.h
//  MemoryManager
//
//  Created by 童万华 on 2017/11/30.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYObject : NSObject<NSCopying>
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) NSString *name;
@end
