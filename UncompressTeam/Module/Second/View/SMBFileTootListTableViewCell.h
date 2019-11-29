//
//  SMBFileTootListTableViewCell.h
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMBFileTootListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (nonatomic, strong)UILabel *bottomLine;
@property (nonatomic, copy) void(^success)();
@end

NS_ASSUME_NONNULL_END
