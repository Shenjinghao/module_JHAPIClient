//
//  JHAPIClient.m
//  JHAPIClient
//
//  Created by Shenjinghao on 2017/2/6.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import "JHAPIClient.h"
#import <AFHTTPRequestOperationManager.h>
#import <AFURLResponseSerialization.h>
#import <AFURLRequestSerialization.h>

@interface JHAPIClient ()

//该类封装与Web应用程序进行通信通过HTTP，包括要求制作，响应序列化，网络可达性监控和安全性，以及要求经营管理的常见模式
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation JHAPIClient

#pragma mark 初始化
- (instancetype)initWithBaseUrl:(NSURL *)url
{
    self = [super init];
    if (self) {
        [self setBaseUrl:url];
    }
    return self;
}

- (void)setBaseUrl:(NSURL *)url
{
    self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
}

#pragma mark 封装operation，管理content type,
- (AFHTTPRequestOperation *)httpRequsestOperationWithRequest:(NSURLRequest *)urlRequest requestContentType:(JHHttpRequestContentType)requestContentType success:(void (^)(AFHTTPRequestOperation *, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
#warning block这块有区别
//    self.globalSuccessBlock = ^(AFHTTPRequestOperation)
    AFHTTPRequestOperation *operation = [self.manager HTTPRequestOperationWithRequest:urlRequest success:success failure:failure];
    operation.responseSerializer = [self responseSerializerWithRequestContentType:requestContentType];
    return operation;
                                         
                                         
}

#pragma mark 根据不同的content type 返回不同的数据格式，默认是json
- (AFHTTPResponseSerializer *)responseSerializerWithRequestContentType:(JHHttpRequestContentType)requestContentType
{
    switch (requestContentType) {
        case kJHHttpRequestContentTypeJSON:{
            
            //得到的是JSON数据
            //服务器有时返回json数据时，content-type设的是"text/html"
            //2017-02-07 16:47:37.189 JHAPIClient[38245:3260839] 请求失败Request failed: unacceptable content-type: text/html
            AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
            serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
            [serializer setStringEncoding:NSUTF8StringEncoding];
            return serializer;
        }
        case kJHHttpRequestContentTypeXML:{
            AFXMLParserResponseSerializer *serializer = [AFXMLParserResponseSerializer serializer];
            return serializer;
        }
        case kJHHttpRequestContentTypeImage:{
            AFImageResponseSerializer *serializer = [AFImageResponseSerializer serializer];
            return serializer;
        }
            
        default:
            return [AFHTTPResponseSerializer serializer];
    }
}

#pragma mark 封装request方法，并增加超时参数,新增urlProcessBlock
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error
                                   timeOut:(int)timeOut
{
    //url可以拼接参数等等操作
    if (self.urlProcessBlock) {
        URLString = self.urlProcessBlock(URLString);
    }
    URLString = [[NSURL URLWithString:URLString relativeToURL:self.manager.baseURL] absoluteString];
    NSMutableURLRequest *request = [self.manager.requestSerializer requestWithMethod:method URLString:URLString parameters:parameters error:nil];
    request.timeoutInterval = timeOut;
    //对request进行操作
    if (self.requestProcessBlock) {
        request = self.requestProcessBlock(request);
    }
    return request;
}

#pragma mark 不设置超时时间默认10秒
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(id)parameters
                                     error:(NSError *__autoreleasing *)error
{
    return [self requestWithMethod:method URLString:URLString parameters:parameters error:error timeOut:10];
}

#pragma mark 封装组合数据request方法，增加超时参数
- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                              URLString:(NSString *)URLString
                                             parameters:(NSDictionary *)parameters
                              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                                  error:(NSError *__autoreleasing *)error
                                                timeOut:(int)timeOut
{
    //url可以拼接参数等等操作
    if (self.urlProcessBlock) {
        URLString = self.urlProcessBlock(URLString);
    }
    URLString = [[NSURL URLWithString:URLString relativeToURL:self.manager.baseURL] absoluteString];
    NSMutableURLRequest *request = [self.manager.requestSerializer multipartFormRequestWithMethod:method URLString:URLString parameters:parameters constructingBodyWithBlock:block error:nil];
    request.timeoutInterval = timeOut;
    //对request进行操作
    if (self.requestProcessBlock) {
        request = self.requestProcessBlock(request);
    }
    return request;
}

#pragma mark 不设置超时时间默认10秒
- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method
                                              URLString:(NSString *)URLString
                                             parameters:(NSDictionary *)parameters
                              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                                  error:(NSError *__autoreleasing *)error
{
    return [self multipartFormRequestWithMethod:method URLString:URLString parameters:parameters constructingBodyWithBlock:block error:error timeOut:10];
}

#pragma mark GET请求，指定content type
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters requestContentType:(JHHttpRequestContentType)requestContentType success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSURLRequest *request = [self requestWithMethod:@"GET" URLString:path parameters:parameters error:nil];

    AFHTTPRequestOperation *operation = [self httpRequsestOperationWithRequest:request requestContentType:requestContentType success:success failure:failure];
    [self.manager.operationQueue addOperation:operation];
}
#pragma mark GET请求，content type = json
- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [self getPath:path parameters:parameters requestContentType:kJHHttpRequestContentTypeJSON success:success failure:failure];
}
#pragma mark POST请求，指定content type
- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters requestContentType:(JHHttpRequestContentType)requestContentType success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    NSURLRequest *request = [self requestWithMethod:@"POST" URLString:path parameters:parameters error:nil];
    AFHTTPRequestOperation *operation = [self httpRequsestOperationWithRequest:request requestContentType:requestContentType success:success failure:failure];
    [self.manager.operationQueue addOperation:operation];
}
#pragma mark POST请求，content type = json
- (void)posttPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    [self postPath:path parameters:parameters requestContentType:kJHHttpRequestContentTypeJSON success:success failure:failure];
    
}


@end
                                         
                                         
                                         
                                         
                                         
                                         
