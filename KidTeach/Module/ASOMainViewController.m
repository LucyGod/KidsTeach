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

@interface ASOMainViewController ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation ASOMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (ASO_iPhone_6x) {
            make.top.equalTo(self.view).offset(30);
        }
    }];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bg" ofType:@".mp3"];
    [self playerStart:filePath];
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
    NSInteger tag = sender.tag;
    NSLog(@"%ld",tag);
    
    if (tag == 1 || tag == 2 || tag == 3 || tag == 4) {
        
        //判断用户是否已经购买
        YCAnswerView *anview = [[YCAnswerView alloc]init];
        WEAKSELF
        [anview setResultBlock:^{
            ASOSettingViewController *settingVC = [[ASOSettingViewController alloc] init];
            
            [weakSelf presentViewController:settingVC animated:YES completion:nil];
        }];
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.view addSubview:anview];
        anview.sd_layout.spaceToSuperView(padding);
        return;
    }
    
    ASOContentViewController *contentVC = [[ASOContentViewController alloc] init];
    switch (tag) {
        case 0:
            //认识动物
            contentVC.typeName = @"动物";
            break;
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
            //基础识字
        {
            MusicHomeViewController *music = [[MusicHomeViewController alloc] init];
            [self.navigationController pushViewController:music animated:YES];
            return ;
        }
        default:
            break;
    }
    
    [self.navigationController pushViewController:contentVC animated:YES];
}

- (IBAction)settingAction:(id)sender {
    ASOSettingViewController *settingVC = [[ASOSettingViewController alloc] init];
    
    [self presentViewController:settingVC animated:YES completion:nil];
}

@end
