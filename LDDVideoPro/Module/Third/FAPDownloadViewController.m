//
//  FAPDownloadViewController.m
//  LDDVideoPro
//
//  Created by MAC on 19/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPDownloadViewController.h"

@interface FAPDownloadViewController ()<UITextFieldDelegate>

@property (nonatomic, strong)UITextField *textField;

@end

@implementation FAPDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"新建下载任务";
    UIView *bgView  = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 3;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.view.mas_top).offset(40);
    }];
    
    UIImageView *igView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_search"]];
    [bgView addSubview:igView];
    [igView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(30*0.8, 33*0.8));
    }];
    
    [bgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(igView.mas_right).offset(5);
        make.right.equalTo(bgView.mas_right).offset(-5);
        make.top.equalTo(bgView.mas_top).offset(5);
        make.bottom.equalTo(bgView.mas_bottom).offset(-5);
    }];
    
    if (DEBUG) {
        self.textField.text = @"https://v-cdn.zjol.com.cn/280443.mp4";
    }
    
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [downloadButton setTitle:@"开始下载" forState:UIControlStateNormal];
    [downloadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    downloadButton.backgroundColor = [UIColor colorWithHexString:@"5fa6f8"];
    [self.view addSubview:downloadButton];
    [downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(44);
        make.top.equalTo(bgView.mas_bottom).offset(30);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"下载内容来源于第三方，于本软件无关，请自行甄别";
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(downloadButton);
        make.height.mas_equalTo(40);
        make.top.equalTo(downloadButton.mas_bottom).offset(20);
    }];
}

- (void)addClick {
    if (self.textField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"网址不能为空"];
        return;
    }
    if (self.addSuccess) {
        NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
        [def setObject:@"YES" forKey:@"k_download"];
        [def synchronize];
        self.addSuccess(self.textField.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入视频下载地址";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeySearch;
    }
    return _textField;
}

@end
