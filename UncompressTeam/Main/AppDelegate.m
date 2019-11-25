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
    
    [self configSys:launchOptions];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor clearColor];
    
    UITabBarController *tabBarController = [[UIMainConstructor sharedUIConstructor] constructUI];
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
        
    return YES;
}

- (void)configSys:(NSDictionary*)launchOptions {
    [UMConfigure initWithAppkey:@"5dd62ecf570df3fc4e000a67" channel:@"App Store"];
    [self jpushRegWithAppKey:@"cc3219240a331db0ec09af10" launchOptions:launchOptions];
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
