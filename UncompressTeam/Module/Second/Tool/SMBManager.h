//
//  SMBManager.h
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMBManager : NSObject
+ (instancetype)sharedInstance;

@property (nonatomic,strong)SMBFileServer *fileServer;
@end

NS_ASSUME_NONNULL_END
