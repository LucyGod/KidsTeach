//
//  UMUIConstructor.m
//  youmei
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 um. All rights reserved.
//

#import "UIMainConstructor.h"
#import "FourthViewController.h"
#import "SecondViewController.h"
#import "FirstViewController.h"
#import "ThirdViewController.h"
#import "LYTBaseNavigationController.h"
static const NSArray *imageNames;
static const NSArray *selectedImageNames;
static UIMainConstructor *constructor;

@interface UIMainConstructor ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabBarController;

//@property (nonatomic, assign) BOOL isShowBar;
@end

@implementation UIMainConstructor


+ (instancetype)sharedUIConstructor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        constructor = [[UIMainConstructor alloc] init];
        
        
    });
    return constructor;
}


- (instancetype)init
{
    if (self = [super init])
    {
        if (!imageNames) {
            imageNames = @[@"1",
                           @"1",
                           
                           @"1",
                           @"1"
            ];
        }
        
        if (!selectedImageNames) {
            selectedImageNames = @[@"a",
                                   @"a",
                                   
                                   @"a",
                                   @"a"
            ];
        }
        
        
    }
    return self;
}



- (UITabBarController *)constructUI
{
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    [self setupViewControllers];
    
    return self.tabBarController;
}

//设置UI层次结构
- (void)setupViewControllers
{
    
    
    // 主页
    FirstViewController *homeVc = [[FirstViewController alloc] init];
    
    homeVc.title = @"主页";
    homeVc.hidesBottomBarWhenPushed = NO;
    LYTBaseNavigationController *homeNC = [[LYTBaseNavigationController alloc] initWithRootViewController:homeVc];
    
    //发现
    SecondViewController *findVc = [[SecondViewController alloc] init];
    findVc.title = @"发现";
    findVc.hidesBottomBarWhenPushed =NO;
    LYTBaseNavigationController *findNC = [[LYTBaseNavigationController alloc] initWithRootViewController:findVc];
    
    //社区
    ThirdViewController *CircleVc = [[ThirdViewController alloc] init];
    CircleVc.title = @"课程";
    CircleVc.hidesBottomBarWhenPushed =NO;
    LYTBaseNavigationController *circleNC = [[LYTBaseNavigationController alloc] initWithRootViewController:CircleVc];
    
    //我的
    FourthViewController *meVc = [[FourthViewController alloc] init];
    meVc.title = @"我的";
    meVc.hidesBottomBarWhenPushed =NO;
    LYTBaseNavigationController *meNC = [[LYTBaseNavigationController alloc] initWithRootViewController:meVc];
    
    
    self.tabBarController.viewControllers = @[
        homeNC,
        findNC,
        circleNC,
        meNC
    ];
    
    
    [self.tabBarController.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        UIImage *image = [UIImage imageNamed:imageNames[idx]];
        UIImage *imageSelected = [UIImage imageNamed:selectedImageNames[idx]];
        item.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }];
    
    self.tabBarController.tabBar.barTintColor = RGBCOLOR(19, 29, 50);
    self.tabBarController.tabBar.translucent = NO;
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.whiteColor,
                                                        NSFontAttributeName:[UIFont fontWithName:fFont size:10.f]
    } forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(13, 117, 254)} forState:UIControlStateSelected];
    [UITabBarItem appearance].titlePositionAdjustment = UIOffsetMake(0, -2.0f);
}


@end
