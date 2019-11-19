//
//  FileSystemCollectionViewCell.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FileSysCellDelegate <NSObject>

- (void)didClickedDeleteButton:(UICollectionViewCell*)cell;

@end

@interface FileSystemCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *directoryNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *deleteIconButton;

@property (weak, nonatomic) id <FileSysCellDelegate> delegate;


/// 显示删除图标
- (void)showDeleteIcon;


/// 隐藏删除图标
- (void)hideDeleteIcon;


/// 点击了删除按钮
/// @param sender btn
- (IBAction)deleteBtnAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
