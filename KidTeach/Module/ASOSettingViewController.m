//
//  ASOSettingViewController.m
//  KidTeach
//
//  Created by MAC on 13/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ASOSettingViewController.h"
#import "ASOCustomButton.h"
#import <StoreKit/StoreKit.h>
@interface ASOSettingViewController ()

@end

@implementation ASOSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg01_lianshuzi"]];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@28);
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(self.view).offset(NavMustAdd);
    }];
    
    UIImageView *contentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buyBg"]];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(NavMustAdd + 160);
        make.size.mas_equalTo(CGSizeMake(75*2, 96*2));
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = [UIFont boldSystemFontOfSize:38];
    moneyLabel.text = @"￥ 45";
    [contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.top.equalTo(contentView.mas_top).offset(40);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *foreverLabel = [[UILabel alloc] init];
    foreverLabel.textColor = [UIColor whiteColor];
    foreverLabel.textAlignment = NSTextAlignmentCenter;
    foreverLabel.font = [UIFont boldSystemFontOfSize:14];
    foreverLabel.text = @"永久";
    [contentView addSubview:foreverLabel];
    [foreverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView.mas_bottom).offset(0);
        make.height.mas_equalTo(30);
    }];
    
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont boldSystemFontOfSize:14];
    messageLabel.text = @"去除广告";
    [contentView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(contentView.mas_bottom).offset(-50);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = [UIFont boldSystemFontOfSize:14];
    detailLabel.text = @"解锁所有功能";
    [contentView addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(messageLabel.mas_top).offset(0);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView);
    }];
    
    UIButton *reBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reBuyBtn addTarget:self action:@selector(reBuyAction) forControlEvents:UIControlEventTouchUpInside];
    [reBuyBtn setBackgroundImage:[UIImage imageNamed:@"reBuy"] forState:UIControlStateNormal];
    [self.view addSubview:reBuyBtn];
    [reBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(contentView.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(58*2, 18*2));
    }];
    
    ASOCustomButton *shareButton = [[ASOCustomButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
    [self.view addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(- 60);
        make.top.equalTo(reBuyBtn.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    ASOCustomButton *storeButton = [[ASOCustomButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [storeButton addTarget:self action:@selector(storeAction) forControlEvents:UIControlEventTouchUpInside];
    [storeButton setTitle:@"评分" forState:UIControlStateNormal];
    [storeButton setImage:[UIImage imageNamed:@"zan_icon"] forState:UIControlStateNormal];
    [self.view addSubview:storeButton];
    [storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(60);
        make.top.equalTo(reBuyBtn.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
}

- (void)backButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/// 内购
- (void)buyAction{
    
}

/// 回复购买
- (void)reBuyAction{
    
}

- (void)shareAction{
     NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
     //app名称
     NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];

    //分享的标题
    NSString *textToShare = app_Name;
    //分享的图片
    UIImage *imageToShare = [UIImage imageNamed:@"logo"];
    //分享的url
    NSURL *urlToShare = [NSURL URLWithString:@"https://itunes.apple.com/app/1487769641"];
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare,imageToShare, urlToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}

- (void)storeAction{
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    }
}

@end
