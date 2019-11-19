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

- (void)configSubViews{
    
    UIImageView *noDataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NoFileIcon"]];
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
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(noDataView.mas_bottom).offset(12);
    }];
}

@end
