//
//  FAPAppDelegate.m
//  KidTeach
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "AppDelegate.h"
#import "ASOMainViewController.h"

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
    
    return YES;
    
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
