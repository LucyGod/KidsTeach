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
@interface ASOContentViewController ()<DetailContentTopViewDelegate>{
    ASODetailContentTopView *_topCollectionView;
    NSDictionary *_tempDataDic;
}

@end

@implementation ASOContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[VoiceHelper sharedInstance] setSpeechSynthesizerDelegate:self];
    
    [self initSubViews];
    
    [self setDefaultValue];
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
        make.top.equalTo(self.contentBGView.mas_top).offset(45);
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
}

- (IBAction)contentVoiceButtonAction:(id)sender {
       //当前json dic
    //    _tempDataDic[@"content"];
    [[VoiceHelper sharedInstance] startSpeaking:_tempDataDic[@"content"] withParamaters:nil];
}

- (void) onCompleted:(IFlySpeechError*) error {
    
}
@end
