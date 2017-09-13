//
//  TYDBTool.h
//  RCTTest
//
//  Created by 童万华 on 2017/9/13.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>
@interface TYDBTool : NSObject
+(instancetype)shareInstance;
@property (nonatomic,strong) FMDatabase *db;
@end
