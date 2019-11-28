//
//  TitleSwitchTableViewCell.h
//  UncompressTeam
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TitleSwitchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *mySwith;
@property (nonatomic, strong)UILabel *bottomLine;

@end

NS_ASSUME_NONNULL_END
