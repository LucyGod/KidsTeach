//
//  NetworkTool.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACSMError.h"

typedef NS_ENUM(NSUInteger, HTTPRequestMethod) {
    HTTPRequestMethodGet,
    HTTPRequestMethodPost,
    HTTPRequestMethodPut,
    HTTPRequestMethodPatch,
    HTTPRequestMethodDelete,
};


NS_ASSUME_NONNULL_BEGIN

@interface NetworkTool : NSObject

+ (instancetype)sharedNetworkTool;

/**
 *  request
 *
 *  @param method        method(SDHTTPRequestMethod)
 *  @param urlString     urlString
 *  @param parameters    parameters
 *  @param completeBlock completeBlock
 */
- (void)toolRequestWithHTTPMethod:(HTTPRequestMethod)method
                        URLString:(NSString *)urlString
                       parameters:(NSDictionary *)parameters
                         complete:(void (^)(id responseObject, ACSMError *error))completeBlock;

/**
 *  request cancel
 */
-(void)cancelRequest;

@end

NS_ASSUME_NONNULL_END
