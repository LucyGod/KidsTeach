//
//  PlayerViewController.h
//  LDDVideoPro
//
//  Created by mac on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewController : UIViewController


/// 网络视频
/// @param videoUrl 视频url
- (void)playWithVideoUrl:(NSString *)videoUrl;


/// 本地视频播放
/// @param FilePath 视频文件地址：带后缀
- (void)playWithVideoFilePath:(NSString *)FilePath;

@end

NS_ASSUME_NONNULL_END
