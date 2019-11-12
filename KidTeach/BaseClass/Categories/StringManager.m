//
//  StringManager.m
//  iHouse
//
//  Created by langyue on 16/3/10.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "StringManager.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation StringManager

/*
 * MD5密码
 */
+(NSString*)MD5:(NSString*)str{
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}

@end
