//
//  FAPNetworkHistoryCell.h
//  LDDVideoPro
//
//  Created by MAC on 18/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAPNetworkHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong)UILabel *bottomLine;

@property (nonatomic, copy) void(^delSuccess)();

@end

NS_ASSUME_NONNULL_END
