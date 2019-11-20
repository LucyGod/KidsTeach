//
//  FAPAppDelegate.m
//  LDDVideoPro
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+JPush.h"
#import <UMAnalytics/MobClick.h>
#import <UMCommon/UMCommon.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self configSys:launchOptions];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    
    UITabBarController *tabBarController = [[UIMainConstructor sharedUIConstructor] constructUI];
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
        
    return YES;
}

- (void)configSys:(NSDictionary*)launchOptions {
    [UMConfigure initWithAppkey:@"5dcbce42570df39fad00044f" channel:@"App Store"];
    [self jpushRegWithAppKey:@"5ffcc70af91a611b474d2642" launchOptions:launchOptions];
    //GoogleAd
    [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
}
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    if (self.allowRotation)
    {
        return  UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}
@end
