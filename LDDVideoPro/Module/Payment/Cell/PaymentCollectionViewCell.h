//
//  PaymentCollectionViewCell.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *futuresImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)configCell:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
