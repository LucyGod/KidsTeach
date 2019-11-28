//
//  SMBListFileViewController.h
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SMBListFileViewController : FAPBaseViewController

@property (nonatomic, strong) SMBShare *share;

@property (nonatomic, strong) SMBFile *file;

@end

NS_ASSUME_NONNULL_END
