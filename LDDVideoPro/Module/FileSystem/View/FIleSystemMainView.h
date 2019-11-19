//
//  FIleSystemMainView.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileSystemCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FileMainDelegate <NSObject>


/// 点击了某一个文件夹
/// @param indexPath indexpath
- (void)didSelecteFileItemAtIndexPath:(NSIndexPath*)indexPath;


/// 删除某一个文件夹
/// @param indexPath indexpath
- (void)didDeleteFileItemAtIndexPath:(NSIndexPath*)indexPath collectionItem:(FileSystemCollectionViewCell*)cell;

@end

@interface FIleSystemMainView : UIView

@property (nonatomic,weak) id<FileMainDelegate> delegate;

- (void)editFileView;

- (void)endEditFileView;

- (void)updateFileWithDataArray:(NSMutableArray*)dataArray;

@end

NS_ASSUME_NONNULL_END
