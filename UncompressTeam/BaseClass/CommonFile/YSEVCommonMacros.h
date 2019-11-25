//
//  YSEVCommonMacros.h
//  KuaiHaoSheng
//
//  Created by  on 2018/3/31.
//  Copyright © 2018年. All rights reserved.
//

//全局标记字符串，用于 通知 存储

#ifndef YSEVCommonMacros_h
#define YSEVCommonMacros_h

#pragma mark - ——————— 用户相关通知 ————————
//登录状态改变通知
#define KNotificationLoginStateChange @"loginStateChange"
//聊天室改动
#define kNotificationChatChange @"chatNotiChange"
//贴吧
#define kNotificationPostBarChange @"postBarNotiChange"

#pragma mark - ——————— 测试账号 ————————

//默认的账号和密码
#define DEFAULTACCOUNT @"13020021159"
#define DEFAULTPASSWORD @"123456"


#pragma mark - ——————— UserDefault存储信息 ————————

#define APPUSERINFO  @"appuserinfo"
#define APPALLUSERINFO @"appallUserinfo"
#define APPSTOCKCOMBININFO @"stockcombinInfo"//自选的内容
#define APPPUBBarNotice @"pubbarNotice"
#define APPPUBBarCommentNotice @"pubbarCommentNotice"



#pragma mark - ——————— 定义持久化存储 ————————

// 判断字符串是否为空
#define NULLString(string) ((![string isKindOfClass:[NSString class]])||[string isEqualToString:@""] || (string == nil) || [string isEqualToString:@""] || [string isKindOfClass:[NSNull class]]||[[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

#pragma mark - ——————— 网络状态相关 ————————
#pragma mark - ——————— 文字相关 ————————
#define NetworkfailureHubMessage @"网络请求失败,请稍后再试"

#endif /* YSEVCommonMacros_h */
