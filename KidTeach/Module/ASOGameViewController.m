//
//  ASODemoViewController.m
//  KidTeach
//
//  Created by LonelyTown on 2019/11/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ASOGameViewController.h"
#import "FindPicGameView.h"
@interface ASOGameViewController ()<GameSuccessDelegate>{
    UIImageView *_contentView;
    UILabel *_contentTitlelabel;
}

/// 插屏广告
@property (nonatomic, strong) GADInterstitial *Interstitial;

@end

@implementation ASOGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_01"]];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIImageView *bottomKuangView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dikuang"]];
    bottomKuangView.contentMode = UIViewContentModeScaleAspectFit;
    bottomKuangView.userInteractionEnabled = YES;
    [self.view addSubview:bottomKuangView];
    [bottomKuangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.adjustsImageWhenHighlighted = NO;
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomKuangView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_HETERO_SCREEN) {
            make.width.height.equalTo(@35);
        }else{
            make.width.height.equalTo(@28);
        }
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(self.view).offset(NavMustAdd);
    }];
    
    //titleLabel
    _contentTitlelabel = [[UILabel alloc] init];
    _contentTitlelabel.font = [UIFont systemFontOfSize:20 weight:UIFontWeightMedium];
    _contentTitlelabel.numberOfLines = 2;
    _contentTitlelabel.textAlignment = NSTextAlignmentCenter;
    _contentTitlelabel.text = [NSString stringWithFormat:@"亲爱的小朋友，将刚刚学习过的“%@”，全部选出来吧！",_dataDic[@"name"]];
    [bottomKuangView addSubview:_contentTitlelabel];
    [_contentTitlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        if (IS_HETERO_SCREEN) {
            make.top.equalTo(backButton.mas_bottom).offset(32 + NavMustAdd);
        }else{
            make.top.equalTo(backButton.mas_bottom).offset(20 + NavMustAdd);
        }
    }];
    
    //边框
    UIImageView *kuangView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yuan_sz02"]];
    kuangView.contentMode = UIViewContentModeScaleAspectFit;
    kuangView.userInteractionEnabled = YES;
    [self.view addSubview:kuangView];
    [kuangView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(@230);
        make.height.equalTo(@200);
        if (IS_HETERO_SCREEN) {
            make.top.equalTo(_contentTitlelabel.mas_bottom).offset(6+NavMustAdd);
        }else{
            if (ASO_iPhone_6x) {
                make.width.equalTo(@210);
                make.height.equalTo(@170);
                make.top.equalTo(_contentTitlelabel.mas_bottom).offset(25+NavMustAdd);
            }else{
                make.top.equalTo(_contentTitlelabel.mas_bottom).offset(36+NavMustAdd);
            }
        }
    }];
    
    //contentView
    _contentView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_dataDic[@"name"]]];
    _contentView.contentMode = UIViewContentModeScaleAspectFit;
    _contentView.userInteractionEnabled = YES;
    _contentView.layer.cornerRadius = 5.0;
    _contentView.layer.masksToBounds = YES;
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(kuangView);
        make.width.equalTo(@190);
        make.height.equalTo(@100);
    }];
    
    
    //bottom view
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = RGBCOLOR(254, 208, 42);
    bottomView.layer.cornerRadius = 6.0;
    bottomView.layer.masksToBounds = YES;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@200);
        make.top.equalTo(kuangView.mas_bottom).offset(80);
    }];
    
    FindPicGameView *gameView = [[FindPicGameView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width - 40 - 16, 200 - 16) withPicName:_dataDic[@"name"]];
    gameView.delegate = self;
    gameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:gameView];
    [gameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(8);
        make.right.equalTo(bottomView.mas_right).offset(-8);
        make.top.equalTo(bottomView.mas_top).offset(8);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-8);
    }];
    
    if (![[PayHelp sharePayHelp] isApplePay]) {
        [self addAdView];
    }
}

- (void)addAdView{
    //banner广告
    GADBannerView *bannerAdView = [[GADBannerView alloc] init];
    bannerAdView.adUnitID = @"ca-app-pub-6864430072527422/5269911852";
    bannerAdView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[kGADSimulatorID];
    
    [bannerAdView loadRequest:request];
    [self.view addSubview:bannerAdView];
    
    [bannerAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    //插屏广告
    self.Interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-6864430072527422/7321360127"];
    GADRequest *request1 = [GADRequest request];
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[kGADSimulatorID];
    [self.Interstitial loadRequest:request1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([self.Interstitial isReady]) {
        [self.Interstitial presentFromRootViewController:self];
    }
}

- (void)didSuccessGame{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"你真聪明，继续学习！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
