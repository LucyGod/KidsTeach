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

- (BOOL)directoryIsExistWithFullPath:(NSString*)dirName{
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [_manager fileExistsAtPath:dirName isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {//如果文件夹不存在
        return NO;
    }
    return YES;
}

- (BOOL)fileIsExistWithFullPath:(NSString*)dirName{
    BOOL isDir = NO;
    BOOL existed = [_manager fileExistsAtPath:dirName isDirectory:&isDir];
    if (existed) {//如果文件夹不存在
        return YES;
    }
    return NO;
}

- (void)createTxtName:(NSString*)name filePath:(nonnull NSString *)path
{
    NSData *data = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:[path?path:DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",name]] atomically:YES];
}
- (BOOL)createDirectoryWithDirectoryName:(NSString*)name filePath:(nonnull NSString *)path{
    NSString * rarFilePath = [path?path:DocumentsPath stringByAppendingPathComponent:name];//将需要创建的串拼接到后面
    if (![self directoryIsExist:rarFilePath]) {
        return [_manager createDirectoryAtPath:rarFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return NO;
}
#pragma mark - 移动文件(夹)
/*参数1、被移动文件路径
 *参数2、要移动到的目标文件路径
 *参数3、当要移动到的文件路径文件存在，会移动失败，这里传入是否覆盖
 *参数4、错误信息
 */
+ (BOOL)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath overwrite:(BOOL)overwrite error:(NSError *__autoreleasing *)error {
    // 先要保证源文件路径存在，不然抛出异常
    if (![self isExistsAtPath:path]) {
        [NSException raise:@"非法的源文件路径" format:@"源文件路径%@不存在，请检查源文件路径", path];
        return NO;
    }
    //获得目标文件的上级目录
    NSString *toDirPath = [self directoryAtPath:toPath];
    if (![self isExistsAtPath:toDirPath]) {
        // 创建移动路径
        if (![self createDirectoryAtPath:toDirPath error:error]) {
            return NO;
        }
    }
    // 判断目标路径文件是否存在
    if ([self isExistsAtPath:toPath]) {
        //如果覆盖，删除目标路径文件
        if (overwrite) {
            //删掉目标路径文件
            [self removeItemAtPath:toPath error:error];
        }else {
           //删掉被移动文件
            [self removeItemAtPath:path error:error];
            return YES;
        }
    }
    
    // 移动文件，当要移动到的文件路径文件存在，会移动失败
    BOOL isSuccess = [[NSFileManager defaultManager] moveItemAtPath:path toPath:toPath error:error];
    
    return isSuccess;
}
+ (BOOL)removeItemAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    return [[NSFileManager defaultManager] removeItemAtPath:path error:error];
}
+ (BOOL)createDirectoryAtPath:(NSString *)path error:(NSError *__autoreleasing *)error {
    NSFileManager *manager = [NSFileManager defaultManager];
    /* createDirectoryAtPath:withIntermediateDirectories:attributes:error:
     * 参数1：创建的文件夹的路径
     * 参数2：是否创建媒介的布尔值，一般为YES
     * 参数3: 属性，没有就置为nil
     * 参数4: 错误信息
    */
    BOOL isSuccess = [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:error];
    return isSuccess;
}
+ (NSString *)directoryAtPath:(NSString *)path {
    return [path stringByDeletingLastPathComponent];
}
#pragma mark - 判断文件(夹)是否存在
+ (BOOL)isExistsAtPath:(NSString *)path {
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
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
-(BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)toPath
{
     return [_manager copyItemAtPath:path toPath:toPath error:nil];
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
