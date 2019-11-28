//
//  iCloudManager.h
//  UncompressTeam
//
//  Created by MAC on 27/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^downloadBlock)(id obj);

@interface iCloudManager : NSObject

+ (BOOL)iCloudEnable;

+ (void)downloadWithDocumentURL:(NSURL*)url callBack:(downloadBlock)block;

@end

NS_ASSUME_NONNULL_END
