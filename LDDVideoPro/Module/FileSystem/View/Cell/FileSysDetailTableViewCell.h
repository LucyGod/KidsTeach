//
//  FileSysDetailTableViewCell.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileSysDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentSizeLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

NS_ASSUME_NONNULL_END
