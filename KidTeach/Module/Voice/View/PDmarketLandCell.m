

//
//  marketLandCell.m
//  FutureGoodsProject
//
//  Created by mac on 2019/8/2.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PDmarketLandCell.h"

@interface PDmarketLandCell ()
{

    __weak IBOutlet UIView *bgView;
}

@end
@implementation PDmarketLandCell

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
