//
//  FileSystemHandle.h
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FileCollectionViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface FileSystemHandle : NSObject

+(void)fileHandleAlertShowFileName:(NSString*)fileName FilePath:(NSString *)path collectionVC:(FileCollectionViewController*)collVC withVC:(UIViewController*)vc;

+(void)addActionShowViewFilePath:(NSString *)path collectionVC:(FileCollectionViewController*)collVC withVC:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
