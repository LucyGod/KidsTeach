//
//  MusicModel.h
//  KidTeach
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicModel : NSObject
@property (nonatomic, strong) NSNumber *audio_id; // 歌曲id
@property (nonatomic, strong) NSString *audio_name; // 歌曲名
@property (nonatomic, strong) NSString *coverurl; // 图片
@property (nonatomic, strong) NSString *downloadurl; // 歌曲地址
//@property (nonatomic, strong) NSString *singer; // 歌手
//@property (nonatomic, strong) NSString *introduce; // 介绍
@end

NS_ASSUME_NONNULL_END
