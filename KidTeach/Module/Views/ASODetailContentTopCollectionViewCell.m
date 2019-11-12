//
//  ASODetailContentTopCollectionViewCell.m
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ASODetailContentTopCollectionViewCell.h"

@implementation ASODetailContentTopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configCell:(NSDictionary*)dic{
    self.contentImageView.image = [UIImage imageNamed:dic[@"name"]];
}

@end
