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
    self.firstButton.layer.cornerRadius = 5.0;
    self.firstButton.layer.masksToBounds = YES;
    
    self.secondButton.layer.cornerRadius = 5.0;
    self.secondButton.layer.masksToBounds = YES;
    
    self.thirdButton.layer.cornerRadius = 5.0;
    self.thirdButton.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buybuttonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(buyButtonActionHandler:)]) {
        [self.delegate buyButtonActionHandler:sender.tag];
    }
}
@end
