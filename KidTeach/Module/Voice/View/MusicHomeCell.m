

//
//  marketLandCell.m
//  FutureGoodsProject
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "MusicHomeCell.h"

@interface MusicHomeCell ()
{

    __weak IBOutlet UIView *bgView;
}

@end
@implementation MusicHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    bgView.backgroundColor = [UIColor whiteColor];
    // Initialization code
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = 10;
    self.backgroundColor = [UIColor whiteColor];
   
}
@end
