//
//  RotatingView.h
//  KidTeach
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RotatingView : UIView
@property (nonatomic, strong) UIImageView *imageView;

- (void)setRotatingViewLayoutWithFrame:(CGRect)frame;

// 添加动画
- (void)addAnimation;
// 停止
-(void)pauseLayer;
// 恢复
-(void)resumeLayer;
// 移除动画
- (void)removeAnimation;
@end

NS_ASSUME_NONNULL_END
