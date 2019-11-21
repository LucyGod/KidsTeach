//
//  PayMentTableViewCell.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/21.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "PayMentTableViewCell.h"

@implementation PayMentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.buyImageView.layer.cornerRadius = 5.0;
    self.buyImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
