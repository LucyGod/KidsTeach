//
//  PaymentCollectionViewCell.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "PaymentCollectionViewCell.h"

@implementation PaymentCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _futuresImageView.layer.cornerRadius = 4.0;
    _futuresImageView.layer.masksToBounds = YES;
}

- (void)configCell:(NSDictionary*)dic{
    self.contentTitleLabel.text = dic[@"title"];
    self.contentLabel.text = dic[@"content"];
    self.futuresImageView.image = [UIImage imageNamed:dic[@"imageName"]];
}

@end
