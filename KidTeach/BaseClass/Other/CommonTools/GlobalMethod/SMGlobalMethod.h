//
//  SMGlobalMethod.h
//  Smios
//
//  Created by hao on 15/11/27.
//  Copyright (c) 2015年 sanmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMGlobalMethod : NSObject
//date转时间yyyyMMdd
+(NSString *)getTimeFromTimeDaY:(NSDate *)date;
//时间戳转时间
+(NSString *)getTimeFromTimeSp:(NSString *)timeSp;
//时间戳转时间
+(NSString *)getTimeFromShortTimeSpY:(NSString *)shortTimeSp;
//时间戳转时间yyyy-MM-dd
+(NSString *)getTimeFromShortTimeSp:(NSString *)shortTimeSp;
+(NSString *)getTimeFrom13TimeSp:(NSString *)shortTimeSp;
//date转时间
+(NSString *)getTimeFromTimeDa:(NSDate *)date;
+(NSString *)getTimeFromShortTimeDa:(NSDate *)date;
//时间文本转dateShort
+(NSDate *)getTimeDateFromeShortTimeStryy:(NSString *)timeStr;
//将时间转为时间戳
//+ (NSString *)getTimetroWith:
//获取当前时间戳
+(NSString *)getTimeSp;
//时间文本转date
//YYYY-MM-dd HH:mm
+ (NSString *)time:(long long)timeS;
//YYYY-MM-dd
+ (NSString *)timeDay:(long long)timeS;
//HH:mm
+ (NSString *)timeAddHH:(long long)timeS;

//输入参数是NSDate，输出结果是星期几的字符串。
+ (NSString*)weekdayStringFromDate:(long long)timeS;


+(NSDate *)getTimeDateFromeTimeStr:(NSString *)timeStr;
+(NSDate *)getTimeDateFromeShortTimeStr:(NSString *)timeStr;
//date转时间戳
+(NSString *)getTimeSpFromeTimeDate:(NSDate *)date;
//时间文本转date(YYYYMMddHHmm)
+ (NSDate *)getTimeDateFromeTimeStrWithYYY:(NSString *)timeStr;
//date转时间yyyyMMddHHmm
+(NSString *)getTimeFromTimeDaYY:(NSDate *)date;
//自动消失的提示框
+(void)showMessage:(NSString *)message;

//位于中间自动消失的提示框
+(void)showMiddleMessage:(NSString *)message;

#pragma mark-- 正则判断
+ (BOOL)valiString:(NSString *)str;
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//电话号验证
+ (BOOL)validateIsMobileNumber:(NSString *)mobileNum;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//支付密码
+ (BOOL) validatePayPassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//正整数
+ (BOOL) validatePositiveInteger:(NSString *)integerStr;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+(BOOL)checkCardNo:(NSString*)cardNo;

#pragma mark- 各类型数据转换
//字典转data
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict;
//字典转json串
+(NSString*)returnDictionaryToJson:(NSDictionary *)dic;

#pragma mark-- 清理缓存
//计算单个文件大小
+(float)fileSizeAtPath:(NSString *)path;
//计算目录大小
+(float)folderSizeAtPath:(NSString *)path;
//清理缓存
+(void)clearCache:(NSString *)path;

//判断中英混合的的字符串长度
+ (int)convertToInt:(NSString*)strtemp;
/**
 * 字母、数字、中文正则判断（不包括空格）
 */
+ (BOOL)isInputRuleNotBlank:(NSString *)str;

//产生随机色
//+ (UIColor *) randomColor;
//限制输入字符
+ (BOOL)validateNumber:(NSString*)number;

+ (BOOL)validateNULL:(NSString*)number;
+ (BOOL)validateNumberID:(NSString*)number;
// 打开网址
+ (void)openWeb:(NSString *)str;

//手机号判断
+(BOOL)isMobileNumber:(NSString *)mobileNum;
//倒计时
//+(void)startTime:(UIButton *)Btn;
//判断是否是表情
+ (BOOL)stringContainsEmoji:(NSString *)string;
//时间判断
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
// 计算字符尺寸
//+(CGSize)countTextSizeWithText:(NSString *)str font:(CGFloat)font MaxSize:(CGSize)maxSize;
+(void)logoOut;
@end
