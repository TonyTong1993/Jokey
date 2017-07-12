//
//  TYNetWorkingTool.h
//  lepaotiyu
//
//  Created by 童万华 on 2017/6/16.
//  Copyright © 2017年 pengdada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef NS_ENUM(NSUInteger,RequestType){
    GET,
    POST
};
@interface TYNetWorkingTool : NSObject
+(instancetype)shareInstance;

/**
  注册网络监听器

 @param reachabilityStatusChangeBlock 网络状态
 */
-(void)registerNetworkReachabilityManager:(void (^)(AFNetworkReachabilityStatus))reachabilityStatusChangeBlock;

/**
 二次封装GET和POST请求

 @param type 请求类型
 @param url 请求链接地址
 @param params 请求参数
 @param success 成功回掉
 @param failure 失败回掉
 @param progress 进度回掉
 */
-(void)request:(RequestType)type url:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure progress:(void (^)(NSProgress *progress))progress;

@end
