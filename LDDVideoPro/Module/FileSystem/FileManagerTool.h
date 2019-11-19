//
//  FileManagerTool.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileManagerTool : NSObject

+ (instancetype)sharedManagerTool;


/// 判断文件夹是否存在
/// @param dirName 文件夹名称
- (BOOL)directoryIsExist:(NSString*)dirName;

/// 在Document目录下创建文件夹
/// @param name 文件夹名字
- (BOOL)createDirectoryWithDirectoryName:(NSString*)name;


/// 文件夹下的目录
/// @param dirPath 具体文件夹
- (NSMutableArray*)contentsOfDirectory:(NSString*)dirPath;


/// 删除指定目录下的文件
/// @param filePath 文件路径
- (BOOL)deleteFileAtFilePath:(NSString*)filePath;


/// 将文件从一个文件夹移到另一个文件夹
/// @param path 当前path
/// @param toPath 目的path
- (BOOL)moveItemAtPath:(NSString*)path toPath:(NSString*)toPath;

/// 一个目录下的所有文件名字
/// @param path 目录名
- (NSArray*)allPathsAtpath:(NSString*)path;


/// 判断文件是否存在
/// @param filePath 文件路径
- (BOOL)fileExistsAtPath:(NSString*)filePath;

@end

NS_ASSUME_NONNULL_END