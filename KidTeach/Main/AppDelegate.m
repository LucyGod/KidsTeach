//
//  FAPAppDelegate.m
//  KidTeach
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "AppDelegate.h"
#import "ASOMainViewController.h"
#import <iflyMSC/iflyMSC.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ASOMainViewController *homeVC = [[ASOMainViewController alloc] init];
    homeVC.title = @"首页";
    homeVC.hidesBottomBarWhenPushed = NO;
    LYTBaseNavigationController *homeNV = [[LYTBaseNavigationController alloc] initWithRootViewController:homeVC];
    
    self.window.rootViewController = homeNV;
    
    [self.window makeKeyAndVisible];
    
    [self p_setUpServer];
    
    [self p_setUpSVHUD];
    
    [self p_setUPIfly];
    
    return YES;
    
}

- (void)p_setUPIfly {
    [IFlySetting setLogFile:LVL_NONE];
    //打开输出在console的log开关
    [IFlySetting showLogcat:YES];
    //设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"5dc92b76"];
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
}

- (void)p_setUpKeyboardManager {
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)p_setUpServer {
    
    [[ASOServerManager manager]switchServerType:DisServer];
}

- (void)p_setUpSVHUD {
    
    [SVProgressHUD setMinimumDismissTimeInterval:2.0f];
}

@end
