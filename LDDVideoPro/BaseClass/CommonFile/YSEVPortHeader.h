//
//  Header.h
//  KuaiHaoSheng
//
//  Created by Apple on 2018/5/21.
//  Copyright © 2018年 张浩. All rights reserved.
//

#ifndef YSEVPortHeader_h
#define YSEVPortHeader_h

#define kServer_address @"http://ee0168.cn/api/"
#define kServer_infoAddress @"http://infobk.sjwh168.com/"
#define kServer_futuresAddress @"http://hqbk.sjwh168.com/"

#define kServer_newsInfoAddress @"https://zixun.hsmdb.com/news/"

//获取验证码
#define kServer_getCode [kServer_address stringByAppendingString:@"user/getcode"]
//注册
#define kServer_register [kServer_address stringByAppendingString:@"user/register"]
//登录
#define kServer_login [kServer_address stringByAppendingString:@"user/login"]
//忘记密码
#define kServer_forgetpwd [kServer_address stringByAppendingString:@"user/forgetpwd"]

//修改密码
#define kServer_changepwd [kServer_address stringByAppendingString:@"user/alterpwd"]

//新闻--名家讲坛,catgory=socialmedia,catgory=futures
#define kServer_newslist [kServer_infoAddress stringByAppendingString:@"news"]

//期货列表
#define kServer_futureslist [kServer_futuresAddress stringByAppendingString:@"query/current"]

//首页列表
#define kServer_homeFurlist @"http://apibk.sjwh168.com/future/product/list_query"
#define kServer_rankinglist @"http://yw.sjwh168.com/user/financingNo.do"

//资讯列表
#define kServer_getInformation @"getDailyNews"
//资讯详情
#define kServer_getInfoDetail @"getNewsDetail"

#endif /* YSEVPortHeader_h */
