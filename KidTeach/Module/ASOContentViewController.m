//
//  ASOContentViewController.m
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ASOContentViewController.h"
#import "ASODetailContentTopView.h"

@interface ASOContentViewController ()<DetailContentTopViewDelegate>{
    ASODetailContentTopView *_topCollectionView;
}

@end

@implementation ASOContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
}

- (void)initSubViews{
    self.contentImageView.layer.cornerRadius = 5.0;
       self.contentImageView.layer.masksToBounds = YES;
       
       _topCollectionView = [[ASODetailContentTopView alloc] initWithFrame:CGRectZero contentType:self.typeName];
       _topCollectionView.delegate = self;
       [self.contentBGView addSubview:_topCollectionView];
       [_topCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.equalTo(self.contentBGView).offset(20);
           make.right.equalTo(self.contentBGView).offset(-20);
           make.top.equalTo(self.contentBGView.mas_top).offset(45);
           make.height.equalTo(@60);
       }];
}

- (void)didSelectdTopViewItemAtIndexpath:(NSIndexPath *)indexpath param:(NSDictionary *)paramDic{
    NSLog(@"%ld____%@",indexpath.row,paramDic);
    [self updateContentItems:paramDic];
}


/// 刷新页面内容
- (void)updateContentItems:(NSDictionary*)info{
    self.contentImageView.image = [UIImage imageNamed:info[@"name"]];
    self.contentNameLabel.text = info[@"name"];
    self.contentPingYinLabel.text = info[@"PinYin"];
    self.contentLabel.text = info[@"content"];
}

- (IBAction)backButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)voiceButtonAction:(id)sender {
    
}

- (IBAction)tapNextButtonAction:(id)sender {
}

- (IBAction)contentVoiceButtonAction:(id)sender {
}
@end
