//
//  ASODetailContentTopCollectionViewCell.h
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASODetailContentTopCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *borderImageView;

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;


- (void)configCell:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
