//
//  JHAPIClient.h
//  JHAPIClient
//
//  Created by Shenjinghao on 2017/2/6.
//  Copyright © 2017年 JHModule. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFHTTPRequestOperation.h"
//#import "AFURLRequestSerialization.h"

@class AFHTTPRequestOperation;
@class AFURLRequestSerialization;

//typedef void (^JHAPISuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);
//typedef void (^JHAPIFailureBlock) (AFHTTPRequestOperation *operation, NSError *error);
typedef NSString *(^JHAPIURlProcessBlock) (NSString *url);
typedef NSMutableURLRequest *(^JHAPIRequestProcessBlock) (NSMutableURLRequest *request);

// AFNetworking的介绍： http://fann.im/blog/2013/04/29/afnetworking-notes-2/
//
// AFHTTPRequestOperation

typedef enum {
    kJHHttpRequestContentTypeNone,
    kJHHttpRequestContentTypeJSON,
    kJHHttpRequestContentTypeXML,
    kJHHttpRequestContentTypeImage,
} JHHttpRequestContentType;


@interface JHAPIClient : NSObject

//暴漏可以调用的block
//@property (nonatomic, copy)JHAPISuccessBlock globalSuccessBlock;
//@property (nonatomic, copy)JHAPIFailureBlock globalFailureBlock;
@property (nonatomic, copy)JHAPIURlProcessBlock urlProcessBlock;
@property (nonatomic, copy)JHAPIRequestProcessBlock requestProcessBlock;

/**
 初始化

 @param url url
 @return self
 */
- (instancetype)initWithBaseUrl:(NSURL *)url;

- (void) setBaseUrl:(NSURL *)url;

/**
 手动请求

 @param urlRequest url request
 @param requestContentType 请求后的数据类型 默认是JSON
 @param success succes
 @param failure failure
 @return operation
 */
- (AFHTTPRequestOperation *)httpRequsestOperationWithRequest:(NSURLRequest *)urlRequest
                                          requestContentType:(JHHttpRequestContentType)requestContentType
                                                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 get请求

 @param path url，建议使用完整url
 @param parameters 参数
 @param requestContentType 请求的类型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)        getPath:(NSString *)path
             parameters:(NSDictionary *)parameters
     requestContentType:(JHHttpRequestContentType)requestContentType
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)        HttpsGetPath:(NSString *)path
                  parameters:(NSDictionary *)parameters
          requestContentType:(JHHttpRequestContentType)requestContentType
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)        getPath:(NSString *)path
             parameters:(NSDictionary *)parameters
                success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 post请求
 
 @param path url，建议使用完整url
 @param parameters 参数
 @param requestContentType 请求的类型
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)        postPath:(NSString *)path
              parameters:(NSDictionary *)parameters
      requestContentType:(JHHttpRequestContentType)requestContentType
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)       HttpsPostPath:(NSString *)path
                  parameters:(NSDictionary *)parameters
          requestContentType:(JHHttpRequestContentType)requestContentType
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (void)       posttPath:(NSString *)path
              parameters:(NSDictionary *)parameters
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
