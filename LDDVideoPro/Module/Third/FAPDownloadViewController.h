//
//  FAPDownloadViewController.h
//  LDDVideoPro
//
//  Created by MAC on 19/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAPDownloadViewController : FAPBaseViewController

@property (nonatomic, copy) void(^addSuccess)(NSString *url);

@end

NS_ASSUME_NONNULL_END