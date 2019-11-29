//
//  SARUnArchiveANY.h
//  SARUnArchiveANY
//
//  Created by Saravanan V on 26/04/13.
//  Copyright (c) 2013 SARAVANAN. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SSZipArchive.h"
#import <SSZipArchive/SSZipArchive.h>
#define UNIQUE_KEY( x ) NSString * const x = @#x

enum{
    SARFileTypeZIP,
    SARFileTypeRAR
};

static UNIQUE_KEY( rar );
static UNIQUE_KEY( zip );

typedef void(^Completion)(NSArray *filePaths);
typedef void(^Failure)(void);

@interface SARUnArchiveANY : NSObject <SSZipArchiveDelegate>{
    SSZipArchive *_zipArchive;
    NSString *_fileType;
}

@property (nonatomic, strong) NSString *filePath;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *destinationPath;
@property (nonatomic, copy) Completion completionBlock;
@property (nonatomic, copy) Failure failureBlock;


/// 普通方式初始化
/// @param path 文件路径
- (id)initWithPath:(NSString *)path;


/// 解压缩是否需要密码
- (BOOL)isNeedPassword;

/// 解压缩
/// @param dirName 解压缩后的文件夹名
- (void)deCompressWithDirectoryName:(NSString*)dirName;


/// 解压缩
/// @param dirName 加压缩后的文件夹名
/// @param psd 解压缩密码
- (void)deCompressWithDirectoryName:(NSString*)dirName password:(NSString*)psd;



/// 压缩文件
/// @param compressType 压缩类型，rar  zip
/// @param fileName 文件名称
- (void)compressFileWithCompressType:(NSString*)compressType fileName:(NSString*)fileName;

@end
