//
//  ASOContentViewController.m
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ASOContentViewController.h"
#import "ASODetailContentTopView.h"
#import "VoiceHelper.h"
#import "ASODemoViewController.h"

@interface ASOContentViewController ()<DetailContentTopViewDelegate>{
    ASODetailContentTopView *_topCollectionView;
    NSDictionary *_tempDataDic;
}

@end

@implementation ASOContentViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[VoiceHelper sharedInstance] stopSpeak];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self remakeConstraints];
    
    [self setDefaultValue];
}

- (void)remakeConstraints{
    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@28);
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(self.view).offset(NavMustAdd);
    }];
    
    [_contentBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
    
    //加载topview
    [self initSubViews];
    
    [_kuangImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(@230);
        make.height.equalTo(@200);
        if (IS_HETERO_SCREEN) {
            make.top.equalTo(_topCollectionView.mas_bottom).offset(25);
        }else{
            if (ASO_iPhone_6x) {
                make.height.equalTo(@180);
                make.top.equalTo(_topCollectionView.mas_bottom).offset(16);
            }else{
                make.top.equalTo(_topCollectionView.mas_bottom).offset(30);
            }
        }
    }];
    
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_kuangImageView);
        make.top.equalTo(_kuangImageView.mas_top).offset(20);
        make.width.equalTo(@190);
        make.height.equalTo(@80);
    }];
    
    [_contentPingYinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_kuangImageView);
        make.top.equalTo(_contentImageView.mas_bottom).offset(8);
    }];
    
    [_contentNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_kuangImageView);
        make.top.equalTo(_contentPingYinLabel.mas_bottom).offset(8);
    }];
    
    [_nameVoiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@35);
        make.top.right.equalTo(_kuangImageView);
    }];
    
    [_detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_kuangImageView.mas_centerY);
        make.right.equalTo(self.view).offset(-30);
        make.width.height.equalTo(@35);
    }];
    
    [_contentVoiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-50);
        make.width.height.equalTo(@35);
        make.top.equalTo(_kuangImageView.mas_bottom).offset(100);
        if (ASO_iPhone_6x) {
            make.top.equalTo(_kuangImageView.mas_bottom).offset(90);
        }else{
            make.top.equalTo(_kuangImageView.mas_bottom).offset(100);
        }
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.right.equalTo(self.view).offset(-50);
        make.top.equalTo(_contentVoiceButton.mas_bottom).offset(20);
    }];
}

- (void)setDefaultValue{
    NSDictionary *dataDic = @{};
    if ([_typeName isEqualToString:@"动物"]) {
        dataDic = @{
            @"name": @"鸡",
            @"content" : @"家禽，品种很多，翅膀短，不能高飞；雄性啼能报晓，雌性生的蛋是好食品",
            @"imageName": @"",
            @"EnglishName": @"Chicken",
            @"PinYin":@"jī"
        };
    }else if ([_typeName isEqualToString:@"水果"]) {
        dataDic = @{
            @"name": @"桃子",
            @"content" : @"桃花可以观赏，果实多汁，可以生食，核仁可以使用。",
            @"imageName": @"",
            @"EnglishName": @"Peach",
            @"PinYin":@"táo zi"
        };
    }else if ([_typeName isEqualToString:@"蔬菜"]) {
        dataDic = @{
            @"name": @"香菇",
            @"content" : @"世界第二大食用菌，我国特产之一，素有”山珍“之称",
            @"imageName": @"",
            @"EnglishName": @"Mushroom",
            @"PinYin":@"xiāng gū"
        };
    }else{
        dataDic = @{
            @"name": @"爸爸",
            @"content" : @"爸爸的本领很大",
            @"imageName": @"",
            @"EnglishName": @"Father",
            @"PinYin":@"bà ba"
        };
    }
    
    _tempDataDic = dataDic;
    [self addDefaultVoice];
    [self updateContentItems:dataDic];
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
        if (IS_HETERO_SCREEN) {
            make.top.equalTo(self.backButton.mas_bottom).offset(30 + NavMustAdd);
        }else{
            make.top.equalTo(self.backButton.mas_bottom).offset(10 + NavMustAdd);
        }
        make.height.equalTo(@60);
    }];
    
    
}

- (void)didSelectdTopViewItemAtIndexpath:(NSIndexPath *)indexpath param:(NSDictionary *)paramDic{
    NSLog(@"%ld____%@",indexpath.row,paramDic);
    _tempDataDic = paramDic;
    
    [self addDefaultVoice];
    
    [self updateContentItems:paramDic];
}

- (void)addDefaultVoice{
    NSString *voiceString = [NSString stringWithFormat:@"%@,%@",_tempDataDic[@"name"],_tempDataDic[@"content"]];
    [[VoiceHelper sharedInstance] startSpeaking:voiceString withParamaters:nil];
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
    //当前json dic
    //    _tempDataDic[@"name"];
    [[VoiceHelper sharedInstance] startSpeaking:_tempDataDic[@"name"] withParamaters:nil];
}

- (IBAction)tapNextButtonAction:(id)sender {
    ASODemoViewController *detailContentVC = [[ASODemoViewController alloc] init];
    detailContentVC.dataDic = _tempDataDic;
    [self.navigationController pushViewController:detailContentVC animated:YES];
}

- (IBAction)contentVoiceButtonAction:(id)sender {
    //当前json dic
    //    _tempDataDic[@"content"];
    [[VoiceHelper sharedInstance] startSpeaking:_tempDataDic[@"content"] withParamaters:nil];
}

@end
