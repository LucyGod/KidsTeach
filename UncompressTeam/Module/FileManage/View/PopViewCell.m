//
//  PopViewCell.m
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "PopViewCell.h"

@implementation PopViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.popImage.alpha = 0.5;
        self.popLabel.alpha = 0.5;
    } else {
        [UIView animateWithDuration:0.1 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.popImage.alpha = 1;
            self.popLabel.alpha = 1;
        } completion:nil];
    }
}

@end
