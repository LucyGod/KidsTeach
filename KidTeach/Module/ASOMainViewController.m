//
//  ASOMainViewController.m
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ASOMainViewController.h"
#import "ASOContentViewController.h"
#import "MusicHomeViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ASOSettingViewController.h"
#import "YCAnswerView.h"
#import "SDAutoLayout.h"

@interface ASOMainViewController (){
    NSString *_isQuite;
    UIButton *_backButton;
}

@property (nonatomic, strong) AVPlayer *player;


/// 插屏广告
@property (nonatomic, strong) GADInterstitial *Interstitial;

@end

@implementation ASOMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _isQuite = [[NSUserDefaults standardUserDefaults] valueForKey:@"isQuite"];
    
    [_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (ASO_iPhone_6x) {
            make.top.equalTo(self.view).offset(30);
        }
    }];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    if ([_isQuite isEqualToString:@"关"]) {
        [_backButton setBackgroundImage:[UIImage imageNamed:@"voice_open"] forState:UIControlStateNormal];
    }else{
        [_backButton setBackgroundImage:[UIImage imageNamed:@"voice_close"] forState:UIControlStateNormal];
    }
    _backButton.adjustsImageWhenHighlighted = NO;
    [_backButton addTarget:self action:@selector(voiceCloseButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backButton];
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@45);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(self.view).offset(Status_H);
    }];
    
    [self reMakeConstraints];
    
    if (![[PayHelp sharePayHelp] isApplePay]) {
        [self addAdViews];
    }
}

- (void)reMakeConstraints{
    if (ASO_iPhone_6x) {
        [_animalButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@110);
        }];
        
        [_fruitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@110);
        }];
        
        [_vagetableButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@110);
        }];
        
        [_peopleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@110);
        }];
        
        [_voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@110);
        }];
        
        [_settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@110);
        }];
    }
    
    [self setImageForButton];
}

- (void)setImageForButton{
    if ([PayHelp.sharePayHelp isApplePay]) {
        //已购买
        [_fruitButton setImage:[UIImage imageNamed:@"btn_shuiguo"] forState:UIControlStateNormal];
        [_vagetableButton setImage:[UIImage imageNamed:@"btn_shucai"] forState:UIControlStateNormal];
        [_peopleButton setImage:[UIImage imageNamed:@"btn_jiating"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"btn_voice"] forState:UIControlStateNormal];
        
    }else{
        //未购买
        [_fruitButton setImage:[UIImage imageNamed:@"shuiguo"] forState:UIControlStateNormal];
        [_vagetableButton setImage:[UIImage imageNamed:@"sucai"] forState:UIControlStateNormal];
        [_peopleButton setImage:[UIImage imageNamed:@"jiating"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"tingli"] forState:UIControlStateNormal];
    }
}

- (void)addAdViews{
    //加载广告
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

/// 开关声音
- (void)voiceCloseButtonAction{
    AudioServicesPlaySystemSound(1519);
    if ([_isQuite isEqualToString:@"开"]) {
        _isQuite = @"关";
        [self playerPause];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"voice_open"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setValue:@"关" forKey:@"isQuite"];
    }else{
        _isQuite = @"开";
        [_backButton setBackgroundImage:[UIImage imageNamed:@"voice_close"] forState:UIControlStateNormal];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bg" ofType:@".mp3"];
        [self playerStart:filePath];
        [[NSUserDefaults standardUserDefaults] setValue:@"开" forKey:@"isQuite"];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSString *quite = [[NSUserDefaults standardUserDefaults] valueForKey:@"isQuite"];
    
    if ([quite isEqualToString:@"开"]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bg" ofType:@".mp3"];
        [self playerStart:filePath];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self playerPause];
}

- (void)playerStart:(NSString*)filePath {
    if (!filePath || filePath.length <= 0) {
        NSLog(@"无效的文件");
        return;
    }
    
    // 设置播放的url
    NSURL *url = [NSURL fileURLWithPath:filePath];
    if ([filePath hasPrefix:@"http://"] || [filePath hasPrefix:@"https://"]) {
        url = [NSURL URLWithString:filePath];
    }
    // 设置播放的项目
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    if (self.player == nil) {
        self.player = [[AVPlayer alloc] init];
    }
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self.player play];
}

- (void)playerPause
{
    [self.player pause];
}

- (IBAction)menuButtonAction:(UIButton *)sender {
    AudioServicesPlaySystemSound(1519);
    NSInteger tag = sender.tag;
    NSLog(@"%ld",tag);
    
    ASOContentViewController *contentVC = [[ASOContentViewController alloc] init];
    
    if (tag == 0) {
        contentVC.typeName = @"动物";
        [self.navigationController pushViewController:contentVC animated:YES];
    }else{
        if ([PayHelp.sharePayHelp isApplePay]) {
            //已购买
            switch (tag) {
                case 1:
                    //认识水果
                    contentVC.typeName = @"水果";
                    break;
                case 2:
                    //认识蔬菜
                    contentVC.typeName = @"蔬菜";
                    break;
                case 3:
                    //家庭成员
                    contentVC.typeName = @"家庭成员";
                    break;
                case 4:
                    //宝宝听听
                {
                    MusicHomeViewController *music = [[MusicHomeViewController alloc] init];
                    [self.navigationController pushViewController:music animated:YES];
                    return ;
                }
                default:
                    break;
            }
            
            [self.navigationController pushViewController:contentVC animated:YES];
        }else{
            //未购买，经过家长验证后进入购买页面
            YCAnswerView *anview = [[YCAnswerView alloc]init];
            WEAKSELF
            [anview setResultBlock:^{
                ASOSettingViewController *settingVC = [[ASOSettingViewController alloc] init];
                settingVC.modalPresentationStyle = UIModalPresentationFullScreen;
                [weakSelf presentViewController:settingVC animated:YES completion:nil];
            }];
            UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
            [self.view addSubview:anview];
            anview.sd_layout.spaceToSuperView(padding);
            return;
        }
    }
}

- (IBAction)settingAction:(id)sender {
    AudioServicesPlaySystemSound(1519);
    
    //判断用户是否已经购买
    YCAnswerView *anview = [[YCAnswerView alloc]init];
    [anview setResultBlock:^{
        [self showBuyVC];
    }];
    UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:anview];
    anview.sd_layout.spaceToSuperView(padding);
}

- (void)showBuyVC{
    ASOSettingViewController *settingVC = [[ASOSettingViewController alloc] init];
    settingVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:settingVC animated:YES completion:nil];
}

@end
