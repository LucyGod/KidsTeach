//
//  FileSystemMoveSelecteView.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FileSystemMoveViewDelegate <NSObject>

- (void)moveFilesCompletionHandler;

@end

@interface FileSystemMoveSelecteView : UIView

@property (nonatomic,weak) id <FileSystemMoveViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
