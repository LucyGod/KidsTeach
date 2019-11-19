//
//  FileSystemDetailSectionView.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileSystemDetailSectionView.h"

@implementation FileSystemDetailSectionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews{
    self.backgroundColor = kTabBarBackgroundColor;
    
    //总容量
    UILabel *amountlabel = [[UILabel alloc] init];
    amountlabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightThin];
    CGFloat diskAmount = [UIDevice currentDevice].diskSpace / (1024 * 1024 * 1024);
    amountlabel.text = [NSString stringWithFormat:@"总：%.fG",diskAmount];
    amountlabel.textColor = [UIColor lightGrayColor];
    [self addSubview:amountlabel];
    [amountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-NavMustAdd/2);
        make.left.equalTo(self).offset(12);
    }];
    
    //剩余
    UILabel *lastlabel = [[UILabel alloc] init];
    lastlabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightThin];
    CGFloat diskLast = [UIDevice currentDevice].diskSpaceFree / (1024 * 1024 * 1024);
    lastlabel.text = [NSString stringWithFormat:@"余：%.fG",diskLast];
    lastlabel.textColor = [UIColor lightGrayColor];
    [self addSubview:lastlabel];
    [lastlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(amountlabel.mas_centerY);
        make.right.equalTo(self).offset(-12);
    }];
    
    UIProgressView *progressView = [[UIProgressView alloc] init];
    progressView.progress = 1 - diskLast / diskAmount;
    [self addSubview:progressView];
    [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(amountlabel.mas_right).offset(8);
        make.right.equalTo(lastlabel.mas_left).offset(-8);
        make.centerY.equalTo(amountlabel.mas_centerY);
        make.height.equalTo(@4);
    }];
}

@end
