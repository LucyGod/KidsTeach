//
//  FAPBaseView.h
//  KidTeach
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//


#import "FAPHTTPRequest.h"
#import "FAPRequestSerializer.h"
#import "FAPResponseSerializer.h"

@implementation FAPHTTPRequest
    
+ (instancetype) sharedInstance {
    static FAPHTTPRequest *networking = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networking = [[self alloc]init];
    });
    return networking;
}
    
- (instancetype)init {
    if (self = [super init]) {
        _manager = [[AFHTTPSessionManager alloc]init];
        _manager.requestSerializer = [[FAPRequestSerializer alloc] init];
        _manager.responseSerializer = [[FAPResponseSerializer alloc] init];

    }
    return self;
}
    
- (void)oneGet:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,STRINGNOTNIL(path)];
    
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            
            successBlock(task ,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (faileBlock) {
            faileBlock(task,error);
        }
    }];
}
    
- (void)onePost:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,STRINGNOTNIL(path)];
    
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            
            successBlock(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (faileBlock) {
            faileBlock(task, error);
        }
    }];
}



/**
 带header的请求
 */
- (void)oneGet:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters header:(NSDictionary *)header success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock {
    
    if (header != nil && header.count > 0) {
        
        for (NSString * key in header) {
            NSString *value  = [header objectForKey:key];
            
            [self.manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,STRINGNOTNIL(path)];
//    Log(@"请求URL---%@",url);
    [self.manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            
            successBlock(task ,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (faileBlock) {
            faileBlock(task,error);
        }
    }];
}

- (void)onePost:(NSString*)baseUrl path:(NSString *)path parameters:(id)parameters header:(NSDictionary *)header success:(SuccessBlock)successBlock faile:(FaileBlock)faileBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%@",baseUrl,STRINGNOTNIL(path)];
    
    if (header != nil && header.count > 0) {
        
        for (NSString * key in header) {
            NSString *value  = [header objectForKey:key];
            
            [self.manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
    
    [self.manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (successBlock) {
            
            successBlock(task, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (faileBlock) {
            faileBlock(task, error);
        }
    }];
}
@end
