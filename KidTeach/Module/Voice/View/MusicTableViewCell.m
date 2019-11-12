//
//  MusicTableViewCell.m
//  KidTeach
//
//  Created by mac on 2019/11/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "MusicTableViewCell.h"

@implementation MusicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.BgImgView.layer.masksToBounds = YES;
    self.BgImgView.layer.cornerRadius = 10;
    
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 10;
    self.imgView.layer.borderWidth = 2;
    self.imgView.layer.borderColor = [UIColor colorWithRed:44/255.0 green:180/255.0 blue:220/255.0 alpha:1].CGColor;
//     self.imgView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
