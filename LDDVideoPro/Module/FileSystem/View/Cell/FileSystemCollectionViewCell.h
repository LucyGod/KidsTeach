//
//  FileSystemCollectionViewCell.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileSystemCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;

@end

NS_ASSUME_NONNULL_END
