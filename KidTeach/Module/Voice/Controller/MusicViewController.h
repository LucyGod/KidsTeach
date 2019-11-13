//
//  MainMusicViewController.h
//  KidTeach
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicViewController : LYTBaseViewController
-(void)LoadDataTypeStr:(NSString *)str;
@property (nonatomic ,copy) NSString *nameStr;

@end

NS_ASSUME_NONNULL_END
