//
//  NSString+Verify.m
//  ASO
//
//  Created by liubin on 2018/9/26.
//  Copyright © 2018年 ASO. All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)
+( BOOL )verifyEmail:(NSString *)email
{
    return [email containsString:@"@"] && [email containsString:@"."] ;
}
+(BOOL)verifyPhone:(NSString *)phone withCountryArea:(NSString *)code
{
    if (isStrEmpty(phone)||isStrEmpty(code)) {
        return NO;
    }
    if ([code isEqualToString:@"+86"] || [code isEqualToString:@"86"]) {
        if (phone.length == 11) {
            NSString *phoneRegex = @"[1][3456789]\\d{9}";
            NSPredicate *PhoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
            return [PhoneTest evaluateWithObject:phone];
        }
        return NO;
    }
    return YES;
}

+(BOOL)verifyPassword:(NSString *)password
{
////    NSString *passwordRegex = @"(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)[\\s\\S]{8,30}";
//    NSString *passwordRegex = @"(?!^\\d+$)(?!^[a-zA-Z]+$)(?!^[_#@]+$).{8,30}"; //1、密码必须由数字、字符、特殊字符三种中的两种组成； 2、密码长度不能少于8个字符；
//    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
//    return [passwordTest evaluateWithObject:password];
    
    if (password.length >= 4) {
        return YES;
    }else {
        return NO;
    }
}
//判断是否有中文
+(BOOL)isChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

/* 是否全部是字母 */
+ (BOOL)isWholeEnglish:(NSString *)string {
    
    if (isStrEmpty(string)) {
        return NO;
    }
    
    NSString *regex =@"[a-zA-Z]*";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    
    return [pred evaluateWithObject:string];
}



/**
 校验验证码

 @param code 验证码
 @param CodeType 验证码类型
 @return 是否校验通过
 */
+ (BOOL)verifySecurityCode:(NSString *)code codeType:(SecurityCodeType)CodeType {
    BOOL isLegal = NO;
    
    if (isStrEmpty(code) || CodeType <= 0) {
        return isLegal;
    }
    
    switch (CodeType) {
        case SecurityCodeTypePhone:
            {
                isLegal = [self verifyFigure:code digit:6];
            }
            break;
        case SecurityCodeTypeGoogle2FA:
        {
            isLegal = [self verifyFigure:code digit:6];
        }
            break;
        case SecurityCodeTypeEmail:
        {
            isLegal = [self verifyFigure:code digit:6];
        }
            break;

        default:
            break;
    }

    return isLegal;
}

/**
 验证是否是digit位的纯数字

 @param figure 需要验证的字符串
 @param digit 位数限制
 @return 符合要求返回YES
 */
+ (BOOL)verifyFigure:(NSString *)figure digit:(NSInteger)digit {
    BOOL isLegal = NO;
    if (isStrEmpty(figure) || digit <= 0) {
        return isLegal;
    }
    
    NSString *regex = [NSString stringWithFormat:@"^\\d{%d}$",digit];
    NSPredicate *regexPreDicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    isLegal = [regexPreDicate evaluateWithObject:figure];
    return isLegal;
}

/* 验证是否是纯数字 */
+ (BOOL)verifyFigure:(NSString *)figure {
    BOOL isLegal = NO;
    if (isStrEmpty(figure)) {
        return isLegal;
    }
    
    NSString *regex = @"^[0-9]*$";
    NSPredicate *regexPreDicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    isLegal = [regexPreDicate evaluateWithObject:figure];
    return isLegal;
}

@end
