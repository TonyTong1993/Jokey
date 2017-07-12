//
//  TYNetWorkingTool.m
//  lepaotiyu
//
//  Created by 童万华 on 2017/6/16.
//  Copyright © 2017年 pengdada. All rights reserved.
//

#import "TYNetWorkingTool.h"
@interface TYNetWorkingTool()
@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end
@implementation TYNetWorkingTool
+(TYNetWorkingTool *)shareInstance  {
    static dispatch_once_t onceToken;
    static TYNetWorkingTool *_netWorkTool;
    dispatch_once(&onceToken, ^{
        _netWorkTool = [[TYNetWorkingTool alloc] init];
    });
    return _netWorkTool;
}
-(instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    }
    return self;
}
//监听网络变化
-(void)registerNetworkReachabilityManager:(void (^)(AFNetworkReachabilityStatus))reachabilityStatusChangeBlock {
    AFNetworkReachabilityManager *shareManager = [AFNetworkReachabilityManager sharedManager];
    [shareManager setReachabilityStatusChangeBlock:reachabilityStatusChangeBlock];
    [shareManager startMonitoring];
}
//发送网络请求
/*
 1.GET 
 2.POST
 */
-(void)request:(RequestType)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure progress:(void (^)(NSProgress *progress))progress{
    switch (type) {
        case GET:
            [self requestWithGET:url params:params success:success failure:failure progress:progress];
            break;
            
         case POST:
            [self requestWithPOST:url params:params success:success failure:failure progress:progress];
            break;
    }
}
-(void)requestWithGET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure progress:(void (^)(NSProgress *progress))progress{
    id successBlock = ^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject) {
        
        success(responseObject);
    };
    id failureBlock = ^(NSURLSessionDataTask * _Nonnull task,NSError * _Nullable error) {
        
        failure(error);
    };
    id downloadProgressBlock = ^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
    };
    [_manager GET:url parameters:params progress:downloadProgressBlock success:successBlock failure:failureBlock];
}
-(void)requestWithPOST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure progress:(void (^)(NSProgress *progress))progress{
    id successBlock = ^(NSURLSessionDataTask * _Nonnull task,id _Nullable responseObject) {
        
        success(responseObject);
    };
    id failureBlock = ^(NSURLSessionDataTask * _Nonnull task,NSError * _Nullable error) {
        
        failure(error);
    };
    id uploadProgressBlock = ^(NSProgress * _Nonnull uploadProgress) {
         progress(uploadProgress);
    };
    [_manager POST:url parameters:params progress:uploadProgressBlock success:successBlock failure:failureBlock];
}
@end
