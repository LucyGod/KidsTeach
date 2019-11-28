//
//  SMBSection0TableViewCell.h
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMBSection0TableViewCell : UITableViewCell <UITextFieldDelegate>
@property (nonatomic, copy) void(^success)(NSString *text);
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentField;
@property (nonatomic, strong)UILabel *bottomLine;
@end

NS_ASSUME_NONNULL_END
