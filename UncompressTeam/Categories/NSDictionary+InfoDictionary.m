//
//  NSDictionary+InfoDictionary.m
//  ASO
//
//  Created by kk_ghostlord on 2018/4/3.
//  Copyright © 2018年 ASO. All rights reserved.
//

#import "NSDictionary+InfoDictionary.h"

@implementation NSDictionary (InfoDictionary)

/**
 获得Info.plist数据字典,防止infoPlist 文件更换路径导致获取不到的问题
 */
+ (NSDictionary *)ASO_getInfoDictionary {
    
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    
    if (!infoDict || !infoDict.count) {
        infoDict = [NSBundle mainBundle].localizedInfoDictionary;
    }
    
    if (!infoDict || !infoDict.count) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        infoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    
    return infoDict ? infoDict : @{};
}

/* 获得当前App的版本号 */
+ (NSString *)ASO_getCurrentVersion {
    NSString *version = @"";
    NSDictionary *infoDictionary = [NSDictionary ASO_getInfoDictionary];
    if (infoDictionary) {
        version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    return version;
}

    /* 获得当前App的编译版本 */
+ (NSString *)ASO_getCurrentBuildVersion {
    NSString *buildVersion = @"";
    NSDictionary *infoDictionary = [NSDictionary ASO_getInfoDictionary];
    if (infoDictionary) {
        buildVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    }
    return buildVersion;
}
    
/* 获得当前App的渠道 */
+ (NSString *)ASO_getChannel {
    NSString *channel = @"2002";
    NSDictionary *infoDictionary = [NSDictionary ASO_getInfoDictionary];
    if (infoDictionary) {
        channel = [infoDictionary objectForKey:@"App_channel"];
    }
    return channel;
}

/* 获得当前App的签名id */
+ (NSString *)ASO_getEnterpriseSignId {
    
    NSString *signId = @"0";
    NSDictionary *infoDictionary = [NSDictionary ASO_getInfoDictionary];
    if (infoDictionary) {
        signId = [infoDictionary objectForKey:@"App_enterprise_dign_id"];
    }
    return signId;
}

@end
