//
//  FAPBaseViewController.h
//  LDDVideoPro
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 将要返回

 @param backBtn 返回按钮
 @return 是否允许返回
 */
typedef BOOL(^VCShouldBackBlock)(UIButton *backBtn);

@interface FAPBaseViewController : UIViewController

/** 返回事件回调 */
@property (copy, nonatomic) VCShouldBackBlock shouldBackBlock;

@end

NS_ASSUME_NONNULL_END
