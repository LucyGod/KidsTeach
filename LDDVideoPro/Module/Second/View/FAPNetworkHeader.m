//
//  FAPNetworkHeader.m
//  LDDVideoPro
//
//  Created by MAC on 18/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPNetworkHeader.h"

@implementation FAPNetworkHeader

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"5fa6f8"];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"    历史记录";
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
