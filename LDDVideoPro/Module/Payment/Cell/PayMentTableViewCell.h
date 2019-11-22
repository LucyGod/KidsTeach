//
//  PayMentTableViewCell.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/21.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PaymentCellDelegate <NSObject>

- (void)buyButtonActionHandler:(NSInteger)tag;

@end

@interface PayMentTableViewCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIImageView *buyImageView;

@property (weak, nonatomic) IBOutlet UIButton *firstButton;

@property (weak, nonatomic) IBOutlet UIButton *secondButton;

@property (weak, nonatomic) IBOutlet UIButton *thirdButton;

@property (weak, nonatomic) id<PaymentCellDelegate> delegate;

- (IBAction)buybuttonAction:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
