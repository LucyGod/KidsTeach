//
//  YSEVCommonUserInfo.h
//  tfbank
//
//  Created by langyue on 2018/7/16.
//  Copyright © 2018年 langyue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAPCommonUserInfo : NSObject

#pragma mark - 基本信息
+ (NSString *)userId;//用户ID
+ (NSString *)phoneNumber;//手机号
+ (NSString *)userName;//用户名
+ (NSString *)password;//密码
+ (UIImage *)headImage;//头像
+ (NSString *)userAccessToken;//token
+ (NSString *)getappVersion;//当前版本
+ (CGFloat)getSimulateCapital;//模拟资金

#pragma mark - 基本方法
+(void)updateInfo:(NSDictionary *)dict; //更新当前账户信息
+(void)saveInfo:(NSDictionary *)dict;//保存当前账户信息
+(void)deleteInfo;//删除当前账户信息
+(void)sendLoginStatusNotification;//发送登录状态
+(void)y_thsendPostBarNotification;//贴吧发送通知

@end
