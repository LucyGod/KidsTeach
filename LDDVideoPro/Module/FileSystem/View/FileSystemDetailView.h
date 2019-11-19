//
//  FileSystemDetailView.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DirectoryDetailDelegate <NSObject>

- (void)didClickedFileWithFilePath:(NSString*)filePath;

- (void)updateSelectedData:(NSMutableArray*)selectedArray;

@end

@interface FileSystemDetailView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, weak) id<DirectoryDetailDelegate> delegate;

- (void)updateDetailView:(NSMutableArray*)dataArray;

@end

NS_ASSUME_NONNULL_END
