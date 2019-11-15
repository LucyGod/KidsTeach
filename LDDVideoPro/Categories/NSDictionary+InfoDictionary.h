//
//  NSDictionary+InfoDictionary.h
//  ASO
//
//  Created by kk_ghostlord on 2018/4/3.
//  Copyright © 2018年 ASO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (InfoDictionary)

/**
 获得Info.plist数据字典,防止infoPlist 文件更换路径导致获取不到的问题
 */
+ (NSDictionary *)ASO_getInfoDictionary;
/* 获得当前App的版本号 */
+ (NSString *)ASO_getCurrentVersion;
/* 获得当前App的编译版本 */
+ (NSString *)ASO_getCurrentBuildVersion;
///* 获得当前App的渠道 */
//+ (NSString *)ASO_getChannel;
///* 获得当前App的签名id */
//+ (NSString *)ASO_getEnterpriseSignId;
@end
