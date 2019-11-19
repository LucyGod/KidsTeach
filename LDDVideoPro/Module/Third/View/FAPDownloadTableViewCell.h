//
//  FAPDownloadTableViewCell.h
//  LDDVideoPro
//
//  Created by MAC on 19/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAPDownloadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIButton *statuButton;
@property (nonatomic, strong)UILabel *bottomLine;

@property (nonatomic, copy) void(^successBlock)(UILabel *progressLabel, UIProgressView *progressView, UIButton *statuButton);

@end

NS_ASSUME_NONNULL_END
