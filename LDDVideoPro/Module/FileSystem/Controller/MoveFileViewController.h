//
//  MoveFileViewController.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/19.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MoveFileSuccessDelegate <NSObject>


/// 移动文件成功
/// @param originPaths 文件原始路径
- (void)didMoveFileSuccessHandler:(NSMutableArray*)originPaths;

@end

@interface MoveFileViewController : FAPBaseViewController


@property (nonatomic,weak) id<MoveFileSuccessDelegate> delegate;

/// 原始路径
@property (nonatomic,strong) NSMutableArray *originPaths;

/// 原始文件夹
@property (nonatomic,copy) NSString *originDirectory;


@end

NS_ASSUME_NONNULL_END
