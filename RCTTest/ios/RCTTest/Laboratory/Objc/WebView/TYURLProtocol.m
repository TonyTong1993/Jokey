//
//  TYURLProtocol.m
//  RCTTest
//
//  Created by 童万华 on 2018/3/5.
//  Copyright © 2018年 童万华. All rights reserved.
//

#import "TYURLProtocol.h"
#import <CocoaSecurity.h>
@interface TYURLProtocol()

@end
static NSMutableDictionary *_responseHeader;
@implementation TYURLProtocol

/**
 决定是否处理当前的URLRequest

 @param request 当前请求
 @return 是否处理
 */
+(BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    NSString *host = [request.URL.host lowercaseString];
    
    if (request.URL.scheme != nil && [host isEqualToString:@"oschina"]) {
        if ([request.URL.host isEqualToString:@"syncHttpRequest"]||[request.URL.host isEqualToString:@"asyncHttpRequest"]) {
            if (_responseHeader == nil) {
                _responseHeader =  (NSMutableDictionary *)@{
                                     @"Access-Control-Allow-Credentials":@"true",
                                     @"Access-Control-Allow-Origin":@"*",
                                     @"Access-Control-Expose-Headers":@"jsStr",
                                     @"Access-Control-Allow-Methods":@"GET,POST,PUT,OPTIONS,HEAD",
                                     @"Access-Control-Allow-Headers":@"Origin,jsStr,Content-Type,X-Request-Width",
                                     @"Access-Control-Max-Age":@"10",
                                     @"Cache-Control":@"no-cache,private",
                                     @"Pragma":@"no-cache,no-store",
                                     @"Expires":@"0",
                                     @"Connection":@"Close"
                                     };
            }
            return YES;
        }
    }
    
    return NO;
}
-(void)startLoading {
    //处理跨域操作,如果是options操作。如果是跨域访问会发送一个options请求，需要response一个权限才会继续走head请求
    //此外，ajax发送的数据无法被接收，需要一个自定义请求头X-Javascript-Header，用来javascript->iOS传递数据
    
    if ([self.request.HTTPMethod isEqualToString:@"OPTIONS"])
    {
        
        NSDictionary * fields_resp = _responseHeader;
        //响应ajax预检请求
        NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:[self.request URL] statusCode:200 HTTPVersion:@"1.1" headerFields:fields_resp];
        [[self client] URLProtocol: self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [[self client] URLProtocol:self didLoadData:[NSData data]];
        [[self client] URLProtocolDidFinishLoading:self];
    }else{
        //实现对ajax正式请求的解析与响应
        [self doRequestToResponse];
    }
    
}

-(void)doRequestToResponse {
    NSDictionary *dic = [self.request.allHTTPHeaderFields copy];
    NSString *jsStr = dic[@"X-Javascript-Header"];  //获取响应头数据
    NSString * userAgentInStorage   = [[NSUserDefaults standardUserDefaults] stringForKey:@"UserAgent"];
    NSString * userAgent =  dic[@"User-Agent"];
    
    //必要时保存user-Agent
    if([NSString isEmptyOrNil:userAgentInStorage] && ![NSString isEmptyOrNil:userAgent])
    {
        [[NSUserDefaults standardUserDefaults] setObject:userAgent forKey:@"UserAgent"];
        [[NSUserDefaults standardUserDefaults] synchronize];

    }
    if([NSString isEmptyOrNil:jsStr])
    {
        [self sendRequestErrorToClient];
        return;
    }

    if([jsStr hasPrefix:@"@"])
    {
        jsStr = [jsStr stringByReplacingOccurrencesOfString:@"@" withString:@""];
    }

    NSData *data = [[[CocoaSecurityDecoder alloc] init] base64:jsStr];
    jsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // 转换
    jsStr = [jsStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    jsStr = [jsStr stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    jsStr = [jsStr stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"];
    jsStr = [jsStr stringByReplacingOccurrencesOfString:@"\0" withString:@"\\0"];
    
//    NSMutableDictionary *jsDic = [jsStr mutableObjectFromJSONString];
//
//    if(jsDic==nil)
//    {
//        NSString * tempJsStr = [jsStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
//        jsDic = [tempJsStr mutableObjectFromJSONString];
//    }
//    if(jsDic==nil)
//    {
//        [UMJS showToast:@"参数解析失败！"];
//        return;
//    }
//
//    NSString *serviceName= jsDic[@"service"];
//    NSString *methodName = jsDic[@"method"];
//    id params = jsDic["params"];
//
//    [------------------处理响应的请结果------------------------]
//    //1.开始处理，略
//    //发送相应数据到Ajax端,假定结果为result
//    NSString * response = [@{@"result":result,@"msg":@"Hello World",@"code":@1} JSONString];
//    [self sendResponseToClient:response];
//    [------------------处理响应的请结果------------------------]
}
-(void) sendResponseToClient:(NSString *) str
{
//    NSData *repData = [str dataUsingEncoding:NSUTF8StringEncoding];
//
//
//    NSMutableDictionary *respHeader = [NSMutableDictionary dictionaryWithDictionary:fields_resp];
//    respHeader[@"Content-Length"] = [NSString stringWithFormat:@"%ld",repData.length];
//
//    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:[self.request URL] statusCode:200 HTTPVersion:@"1.1" headerFields:respHeader];
//
//    [[self client] URLProtocol: self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
//    [[self client] URLProtocol:self didLoadData:repData];
//    [[self client] URLProtocolDidFinishLoading:self];
    
}

//发送错误请求信息
-(void) sendRequestErrorToClient
{
    
//    NSData *data = [@"" dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary * fields_resp =_reponseHeader;
//    NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:[self.request URL] statusCode:400 HTTPVersion:@"1.1" headerFields:fields_resp];
//    [[self client] URLProtocol: self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
//    [[self client] URLProtocol:self didLoadData:data];
//    [[self client] URLProtocolDidFinishLoading:self];
    
}


/**
 返回新的URLRequest

 @param request 当前URLRequest
 @return 新的URLRequest
 */
+(NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}

//处理跳转
-(NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
//    if ([response isKindOfClass:[NSHTTPURLResponse class]])
//    {
//        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
//        if ([HTTPResponse statusCode] == 301 || [HTTPResponse statusCode] == 302)
//        {
//            NSMutableURLRequest *mutableRequest = [request mutableCopy];
//            [mutableRequest setURL:[NSURL URLWithString:[[HTTPResponse allHeaderFields] objectForKey:@”Location”]]];
//            request = [mutableRequest copy];
//            [[self client] URLProtocol:self wasRedirectedToRequest:request redirectResponse:response];
//        }
//    }
//    return request;
    return nil;
}

@end
