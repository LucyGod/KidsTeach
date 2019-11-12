//
//  FAPBaseTableViewCell.m
//  KidTeach
//
//  Created by MAC on 22/10/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPBaseTableViewCell.h"

@implementation FAPBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
        self.bottomLine = [[UILabel alloc] init];
        self.bottomLine.backgroundColor = LINECOLOR;
        [self.contentView addSubview:self.bottomLine];
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(0);
            make.right.equalTo(self.contentView.mas_right).offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
            make.height.mas_equalTo(0.5);
        }];
        self.bottomLine.hidden = YES;
    }
    return self;
}

- (void)showBottomLine{
    self.bottomLine.hidden = NO;
}
- (void)hiddenBottomLine{
    self.bottomLine.hidden = YES;
}
-(void)configUI {
    
}

- (void)setDataWithSourceData:(id)model{
    
}

+(CGFloat)getCellHeightWithString:(NSString *)str{
    return 40;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bottomLine = [[UILabel alloc] init];
    self.bottomLine.backgroundColor = LINECOLOR;
    self.bottomLine.hidden = YES;
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
