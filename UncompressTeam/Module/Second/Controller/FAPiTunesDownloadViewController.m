//
//  FAPiTunesDownloadViewController.m
//  UncompressTeam
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPiTunesDownloadViewController.h"

@interface FAPiTunesDownloadViewController ()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *detailLabel;
@end

@implementation FAPiTunesDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"iTunes传输";
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.detailLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_itunes_share"]];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(40);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.top.equalTo(imageView.mas_bottom).offset(30);
        make.height.mas_equalTo(40);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(120);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = @"此功能可将电脑里的图片/gif/视频通过分享iTunes文件导入到应用程序。";
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.text = @"1.将设备连接到电脑，然后在电脑上打开iTunes。\n2.选择应用程序菜单，然后往下滑到iTunes文件共享。\n3.在iTunes文件共享，选择应用程序。\n4.拖放图片/gif/视频文件或使用添加按钮而添加文件。";
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

@end
