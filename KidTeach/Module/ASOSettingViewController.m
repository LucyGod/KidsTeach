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
#import "PayHelp.h"
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
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    closeButton.adjustsImageWhenHighlighted = NO;
    [closeButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.view).offset(Status_H +  15);
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    
    UIButton *reBuyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reBuyBtn addTarget:self action:@selector(reBuyAction) forControlEvents:UIControlEventTouchUpInside];
    [reBuyBtn setBackgroundImage:[UIImage imageNamed:@"reBuy"] forState:UIControlStateNormal];
    [self.view addSubview:reBuyBtn];
    [reBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view).offset(Status_H +  15);
        make.size.mas_equalTo(CGSizeMake(58*2, 18*2));
    }];
    
    UIImageView *contentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"set_price"]];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(NavMustAdd + 190);
        make.size.mas_equalTo(CGSizeMake(294, 177));
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setBackgroundImage:[UIImage imageNamed:@"set_close"] forState:UIControlStateNormal];
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.mas_left).offset(40);
        make.bottom.equalTo(contentView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"set_ok"] forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.mas_right).offset(-40);
        make.bottom.equalTo(contentView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UILabel *pricyLabel = [[UILabel alloc] init];
       pricyLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightLight];
       pricyLabel.textColor = [UIColor grayColor];
       pricyLabel.numberOfLines = 0;
       pricyLabel.text = @"购买确认时，付款将记入iTunes帐户。除非在当前期间结束前至少24小时关闭自动续订，否则订阅将自动续订。在本期结束前24小时内，账户将收取续期费用，并确定续期费用。";
       [self.view addSubview:pricyLabel];
       [pricyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.view).offset(12);
           make.right.equalTo(self.view).offset(-12);
           if (@available(iOS 11.0, *)) {
               make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20);
           } else {
               make.bottom.equalTo(self.view.mas_bottom).offset(-20);
           }
       }];
    
    ASOCustomButton *shareButton = [[ASOCustomButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"share_icon"] forState:UIControlStateNormal];
    [self.view addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(- 70);
//        if (@available(iOS 11.0, *)) {
//            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-60);
//        } else {
//            make.bottom.equalTo(self.view.mas_bottom).offset(-60);
//        }
        make.bottom.equalTo(pricyLabel.mas_top).offset(-40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];

    ASOCustomButton *storeButton = [[ASOCustomButton alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [storeButton addTarget:self action:@selector(storeAction) forControlEvents:UIControlEventTouchUpInside];
    [storeButton setTitle:@"评分" forState:UIControlStateNormal];
    [storeButton setImage:[UIImage imageNamed:@"zan_icon"] forState:UIControlStateNormal];
    [self.view addSubview:storeButton];
    [storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).offset(70);
//        if (@available(iOS 11.0, *)) {
//            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-60);
//        } else {
//            make.bottom.equalTo(self.view.mas_bottom).offset(-60);
//        }
        make.bottom.equalTo(pricyLabel.mas_top).offset(-40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
   
}

- (void)backButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/// 内购
- (void)buyAction{
    [[PayHelp sharePayHelp] applePayWithProductId:@"com.baby.jianji.45"];
}

/// 回复购买
- (void)reBuyAction{
    [[PayHelp sharePayHelp]restorePurchase];
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
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
@end
