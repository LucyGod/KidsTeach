//
//  FileManagerTool.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileManagerTool.h"


@interface FileManagerTool()

@property (nonatomic,strong)NSFileManager *manager;

@end

@implementation FileManagerTool

+ (instancetype)sharedManagerTool {
    static FileManagerTool *managerTool= nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerTool = [[FileManagerTool alloc] init];
    });
    
    return managerTool;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.manager = [NSFileManager defaultManager];
    }
    return self;
}

- (BOOL)directoryIsExist:(NSString*)dirName{
    NSString * rarFilePath = [DocumentsPath stringByAppendingPathComponent:dirName];
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [_manager fileExistsAtPath:rarFilePath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        return NO;
    }
    return YES;
}

- (BOOL)createDirectoryWithDirectoryName:(NSString*)name{
    NSString * rarFilePath = [DocumentsPath stringByAppendingPathComponent:name];//将需要创建的串拼接到后面
    if (![self directoryIsExist:rarFilePath]) {
        return [_manager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return NO;
}

- (NSMutableArray*)contentsOfDirectory:(NSString *)dirPath{
    NSArray *array = [_manager contentsOfDirectoryAtPath:dirPath error:nil];
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:array];
    [tempArray removeObject:@".DS_Store"];
    
    return tempArray;
}

- (BOOL)deleteFileAtFilePath:(NSString*)filePath{
    return [_manager removeItemAtPath:filePath error:nil];
}

- (BOOL)moveItemAtPath:(NSString*)path toPath:(NSString*)toPath{
    return [_manager moveItemAtPath:path toPath:toPath error:nil];
}

- (NSArray*)allPathsAtpath:(NSString*)path{
    return [_manager subpathsAtPath:path];
}

- (BOOL)fileExistsAtPath:(NSString *)filePath{
    
    //           BOOL isDir = NO;
    //           // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    //           BOOL existed = [fileManager fileExistsAtPath:rarFilePath isDirectory:&isDir];
    //           if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
    //               [fileManager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    //           }
    
    return [_manager fileExistsAtPath:filePath];
}

- (NSDictionary*)fileInfomation:(NSString *)filePath{
    return [_manager attributesOfItemAtPath:filePath error:nil];
}

@end
