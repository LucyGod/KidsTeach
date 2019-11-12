//
//  YSEVCommonUserInfo.m
//  tfbank
//
//  Created by langyue on 2018/7/16.
//  Copyright © 2018年 langyue. All rights reserved.
//

#import "FAPCommonUserInfo.h"

@implementation FAPCommonUserInfo

+ (CGFloat)getSimulateCapital{
    
    return 1000000;
}
+(NSString *)userId{
    
    NSDictionary *info=[[NSUserDefaults standardUserDefaults] dictionaryForKey:APPUSERINFO];
    if (info){
        NSString *temp=[NSString stringWithFormat:@"%@",[info objectForKey:@"id"]];
        if (!stringIsNil(temp)){
            return temp;
        }
    }
    return nil;
}
+ (NSString *)userAccessToken{
    
    NSDictionary *info=[[NSUserDefaults standardUserDefaults] dictionaryForKey:APPUSERINFO];
    if (info)
    {
        NSString *temp=[NSString stringWithFormat:@"%@",[info objectForKey:@"token"]];
        
        if (!stringIsNil(temp))
        {
            return temp;
        }
    }
    return nil;
}
+(UIImage *)headImage{
    
    NSDictionary *info=[[NSUserDefaults standardUserDefaults] dictionaryForKey:APPUSERINFO];
    
    UIImage *headImage=kImage(@"icon_logo");
    
    if (info){
        
        NSData *imageD=[info objectForKey:@"headportrait"];
        
        @try {
            
            if(imageD.length>0){
                
                UIImage *image=[UIImage imageWithData:imageD];
                if(image!=nil){
                    return image;
                }
                return headImage;
            }
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        return headImage;
    }
    
    return headImage;
}
+(NSString *)phoneNumber {
    
    NSDictionary *info=[[NSUserDefaults standardUserDefaults] dictionaryForKey:APPUSERINFO];
    if (info)
    {
        NSString *temp=[NSString stringWithFormat:@"%@",[info objectForKey:@"phone"]];
        
        if (!stringIsNil(temp))
        {
            return temp;
        }
    }
    return nil;
}
+ (NSString *)userName{
    
    NSDictionary *info=[[NSUserDefaults standardUserDefaults] dictionaryForKey:APPUSERINFO];
    if (info)
    {
        NSString *temp=[NSString stringWithFormat:@"%@",[info objectForKey:@"name"]];
        
        if (!stringIsNil(temp))
        {
            return temp;
        }
    }
    return nil;
    
}
+(NSString *)password{
    
    NSDictionary *info=[[NSUserDefaults standardUserDefaults] dictionaryForKey:APPUSERINFO];
    if (info)
    {
        NSString *temp=[NSString stringWithFormat:@"%@",[info objectForKey:@"pwd"]];
        
        if (!stringIsNil(temp))
        {
            return temp;
        }
    }
    return nil;
}
+ (NSString *)getappVersion{
    
    NSDictionary *infoDictionary =  [[NSBundle  mainBundle]infoDictionary];
    //app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return app_build;
}
#pragma mark - 保存info
+(void)saveInfo:(NSDictionary *)dict {
    
    NSMutableDictionary *tempDict=[NSMutableDictionary dictionaryWithCapacity:0];
    for (NSString *key in [dict allKeys])
    {
        id obj=[dict objectForKey:key];
        if (validateString(obj))
        {
            if(dictValidateObj(obj))
            {
                [tempDict setObject:obj forKey:key];
            }
            else
                [tempDict setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
        }
        else [tempDict setObject:@"" forKey:key];
    }
    [[NSUserDefaults standardUserDefaults] setObject:tempDict forKey:APPUSERINFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
#pragma mark - 更新info
+(void)updateInfo:(NSDictionary *)dict
{
    NSDictionary *saveDict=[[NSUserDefaults standardUserDefaults] dictionaryForKey:APPUSERINFO];
    NSMutableDictionary *save_mu=[NSMutableDictionary dictionaryWithDictionary:saveDict];
    for (NSString *key in [dict allKeys])
    {
        if (!nullObject([dict objectForKey:key]))
        {
            [save_mu setObject:[dict objectForKey:key] forKey:key];
        }
        else [save_mu setObject:@"" forKey:key];
    }
    [[NSUserDefaults standardUserDefaults] setObject:save_mu forKey:APPUSERINFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - 删除Info
+(void)deleteInfo{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:APPUSERINFO];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+(void)sendLoginStatusNotification{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotificationLoginStateChange object:nil userInfo:nil];
}
+(void)y_thsendPostBarNotification{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationPostBarChange object:nil userInfo:nil];
}
@end
