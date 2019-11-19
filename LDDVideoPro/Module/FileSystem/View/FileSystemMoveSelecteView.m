//
//  FileSystemMoveSelecteView.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileSystemMoveSelecteView.h"

@interface FileSystemMoveSelecteView(){
    UILabel *_selectedLabel;
}

@end

@implementation FileSystemMoveSelecteView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubViews];
    }
    return self;
}

- (void)configSubViews{
    self.backgroundColor = kTabBarBackgroundColor;
    
    //已选
    _selectedLabel = [[UILabel alloc] init];
    _selectedLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightThin];
    _selectedLabel.text = [NSString stringWithFormat:@"已选：%d",0];
    _selectedLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_selectedLabel];
    [_selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-NavMustAdd/2);
        make.left.equalTo(self).offset(12);
    }];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"选好了" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightThin];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 0.5;
    button.layer.cornerRadius = 4.0;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(moveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
               
        make.right.equalTo(self).offset(-12);
        make.width.equalTo(@50);
        make.centerY.equalTo(_selectedLabel.mas_centerY);
    }];
}

- (void)moveButtonAction{
    
    if ([_selectedLabel.text isEqualToString:@"已选：0"]) {
        [SVProgressHUD showErrorWithStatus:@"未选择任何文件！"];
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(moveFilesCompletionHandler)]) {
        [self.delegate moveFilesCompletionHandler];
    }
}

- (void)updateSelectedCount:(NSMutableArray*)array{
    _selectedLabel.text = [NSString stringWithFormat:@"已选：%ld",array.count];
}

@end
