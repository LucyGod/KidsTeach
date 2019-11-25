//
//  NSString+Verify.h
//  ASO
//
//  Created by liubin on 2018/9/26.
//  Copyright © 2018年 ASO. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/* 验证码类型 */
typedef enum : NSUInteger {
    SecurityCodeTypePhone = 1,
    SecurityCodeTypeGoogle2FA,
    SecurityCodeTypeEmail,
} SecurityCodeType;

@interface NSString (Verify)

+(BOOL)verifyEmail:(NSString *)email;

+(BOOL)verifyPhone:(NSString *)phone withCountryArea:(NSString *)code;

/* 判断字符串是否符合密码规则 (8-30位) */
+(BOOL)verifyPassword:(NSString *)password;

/* 判断是否含有中文 */
+(BOOL)isChinese:(NSString *)str;

/* 是否全部是字母 */
+ (BOOL)isWholeEnglish:(NSString *)string;

/**
 校验验证码
 
 @param code 验证码
 @param CodeType 验证码类型
 @return 是否校验通过
 */
+ (BOOL)verifySecurityCode:(NSString *)code codeType:(SecurityCodeType)CodeType;

@end

NS_ASSUME_NONNULL_END
