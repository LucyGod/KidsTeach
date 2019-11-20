//
//  FileSystemNoDataView.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileSystemNoDataView.h"

@interface FileSystemNoDataView()


/// 无数据描述
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *imageName;

@end

@implementation FileSystemNoDataView

- (instancetype)initWithFrame:(CGRect)frame desc:(NSString *)desc{
    self = [super initWithFrame:frame];
    if (self) {
        self.desc = desc;
        [self configSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame desc:(NSString*)desc imageName:(NSString *)imageName {
    self = [super initWithFrame:frame];
    if (self) {
        self.desc = desc;
        self.imageName = imageName;
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews{
    NSString *imageName = self.imageName.length > 0 ? self.imageName : @"NoFileIcon";
    UIImageView *noDataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    noDataView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:noDataView];
    [noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@100);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = self.desc;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(noDataView.mas_bottom).offset(12);
    }];
}

@end
