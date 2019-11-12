//
//  NetworkTool.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "NetworkTool.h"
#import "AFNetworking.h"
NSString * const XHeaderContentType    = @"Content-Type";

@interface NetworkTool()

@property (nonatomic, strong) AFHTTPSessionManager *httpSessionManager;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation NetworkTool

+ (instancetype)sharedNetworkTool
{
    static NetworkTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[NetworkTool alloc] init];
    });
    
    return tool;
}

- (void)startNetwork
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)endNetwork
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)toolRequestWithHTTPMethod:(HTTPRequestMethod)method
                        URLString:(NSString *)urlString
                       parameters:(NSDictionary *)parameters
                         complete:(void (^)(id responseObject, ACSMError *error))completeBlock{
    
    [self startNetwork];
    
    AFHTTPSessionManager *httpSessionManager = self.httpSessionManager;
    
    httpSessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [httpSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    if ([ACSMUserUtil sharedUserUtil].user.token) {
    //        [httpSessionManager.requestSerializer setValue:[ACSMUserUtil sharedUserUtil].user.token forHTTPHeaderField:@"auth_token"];
    //    }
//      [httpSessionManager.requestSerializer setValue:@"57f55b9ec3b1ae23dab6af30382ae7d5" forHTTPHeaderField:@"sign"];
//     [httpSessionManager.requestSerializer setValue:@"5DC906F0" forHTTPHeaderField:@"T"];
    WEAKSELF
    switch (method) {
        case HTTPRequestMethodGet:{
            [httpSessionManager GET:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [weakSelf endNetwork];
                completeBlock(responseObject, [weakSelf convertError:responseObject]);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [weakSelf endNetwork];
                ACSMError *errorModel = [ACSMError new];
                errorModel.resMsg = @"无法连接，请检查您的网络";
                completeBlock(nil, errorModel);
            }];
            break;
        }
        case HTTPRequestMethodPost: {
            [httpSessionManager POST:urlString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [weakSelf endNetwork];
                completeBlock(responseObject, [weakSelf convertError:responseObject]);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [weakSelf endNetwork];
                ACSMError *errorModel = [ACSMError new];
                errorModel.resMsg = @"无法连接，请检查您的网络";
                errorModel.resCode = 404;
                completeBlock(nil, errorModel);
            }];
            
            break;
        }
        case HTTPRequestMethodPut: {
            [httpSessionManager PUT:urlString
                         parameters:parameters
                            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                [weakSelf endNetwork];
                                completeBlock(responseObject, [weakSelf convertError:responseObject]);
                            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                [weakSelf endNetwork];
                                ACSMError *errorModel = [ACSMError new];
                                errorModel.resMsg = @"无法连接，请检查您的网络";
                                completeBlock(nil, errorModel);
                            }];
            break;
        }
        case HTTPRequestMethodPatch: {
            [httpSessionManager PATCH:urlString
                           parameters:parameters
                              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                  [weakSelf endNetwork];
                                  completeBlock(responseObject, [weakSelf convertError:responseObject]);
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                  [weakSelf endNetwork];
                                  ACSMError *errorModel = [ACSMError new];
                                  errorModel.resMsg = @"无法连接，请检查您的网络";
                                  completeBlock(nil, errorModel);
                              }];
            break;
        }
        case HTTPRequestMethodDelete: {
            [httpSessionManager DELETE:urlString
                            parameters:parameters
                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                   [weakSelf endNetwork];
                                   completeBlock(responseObject, [weakSelf convertError:responseObject]);
                               } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                   [weakSelf endNetwork];
                                   ACSMError *errorModel = [ACSMError new];
                                   errorModel.resMsg = @"无法连接，请检查您的网络";
                                   completeBlock(nil, errorModel);
                               }];
            break;
        }
    }
}

#pragma mark - helper
/**
 *  错误解析
 *
 *  @param responseObject 返回JSON数据
 *
 *  @return 错误
 */
- (ACSMError *)convertError:(id)responseObject
{
    ACSMError *error = [ACSMError new];
    NSDictionary *dict = (NSDictionary *)responseObject;
    error.resCode = [dict[@"returnCode"] integerValue];
    error.resMsg = dict[@"returnMessage"];
    if (error.resCode ==200) {   // 无错误
        return nil;
    }
    
    return error;
}

- (void)cancelRequest
{
    [self endNetwork];
    // 取消之前请求
    [self.httpSessionManager.tasks makeObjectsPerformSelector:@selector(cancel)];
}

- (AFHTTPSessionManager *)httpSessionManager
{
    if (_httpSessionManager == nil) {
        
        _httpSessionManager = [AFHTTPSessionManager manager];
    }
    _httpSessionManager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
    _httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"application/xml",@"text/xml",@"text/json",@"text/plain",@"text/javascript",@"text/html", nil];
    [_httpSessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:XHeaderContentType];
    return _httpSessionManager;
}


- (NSString *)getToken
{
    NSString *token = @"bm9uY2VzdHI9N0Q4RjNDM0NFNUU2NjIxRUJDMTM5Q0VDMkM1REUyQTYmc2lnbmF0dXJlPTEzN0ZGNDVCNzk5NjVCMDI2NTAwQUE0N0UyREE5Q0FEJnRpbWVzdGFtcD0xNTA0ODM2OTgxNjI1";
    return token;
}

@end
