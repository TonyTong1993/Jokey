//
//  TYDBTool.m
//  RCTTest
//
//  Created by 童万华 on 2017/9/13.
//  Copyright © 2017年 童万华. All rights reserved.
//

#import "TYDBTool.h"

@implementation TYDBTool
+(instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static TYDBTool *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:nil] init];
    });
    return _instance;
}
-(instancetype)init {
    self = [super init];
    if (self) {
       NSString *dbPath = [[SandBoxHelper docPath] stringByAppendingPathComponent:@"com.joeky.db"];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        BOOL open = [_dbQueue openFlags];
        NSAssert(open, @"打开数据库失败");
        NSString *sql = @"create table if not exists user_track_table (id INTEGER PRIMARY KEY AUTOINCREMENT, latitude double,longitude double,altitude double,horizontalAccuracy double,verticalAccuracy double,speed double,timestamp int)";
        [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            BOOL success =  [db executeUpdate:sql];
            NSAssert(success, @"创建user_track失败");
        }];
    }
    return self;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    return [TYDBTool shareInstance];
}
-(id)copy {
    return self;
}
-(id)mutableCopy {
    return self;
}
+ (id)copyWithZone:(struct _NSZone *)zone
{
    return self;
}
@end
