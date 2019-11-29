//
//  SARUnArchiveANY.m
//  SARUnArchiveANY
//
//  Created by Saravanan V on 26/04/13.
//  Copyright (c) 2013 SARAVANAN. All rights reserved.
//

#import "SARUnArchiveANY.h"

//#import <SSZipArchive/SSZipArchive.h>
//@import SSZipArchive;
@import UnrarKit;
@import LzmaSDK_ObjC;

@implementation SARUnArchiveANY
//@synthesize completionBlock;
@synthesize failureBlock;


#pragma mark - Init Methods
- (id)initWithPath:(NSString *)path {
	if ((self = [super init])) {
		_filePath = [path copy];
        _fileType = [[NSString alloc]init];
	}

    if (_filePath != nil) {
        _destinationPath = [self getDestinationPath];
    }
	return self;
}

- (id)initWithPath:(NSString *)path andPassword:(NSString*)password{
    if ((self = [super init])) {
        _filePath = [path copy];
        _password = [password copy];
        _fileType = [[NSString alloc]init];
    }
    
    if (_filePath != nil) {
        _destinationPath = [self getDestinationPath];
    }
    return self;
}

#pragma mark - Helper Methods
- (NSString *)getDestinationPath{
    NSArray *derivedPathArr = [_filePath componentsSeparatedByString:@"/"];
    NSString *lastObject = [derivedPathArr lastObject];
    _fileType = [[lastObject componentsSeparatedByString:@"."] lastObject];
    return [_filePath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/%@",lastObject] withString:@""];
}

#pragma mark - 是否需要密码
- (BOOL)isNeedPassword{
    if ([_fileType compare:rar options:NSCaseInsensitiveSearch] == NSOrderedSame ) {
        //判断rar格式的压缩文件是否需要解压密码
        URKArchive *archive = [[URKArchive alloc] initWithPath:_filePath error:nil];
        if (archive.isPasswordProtected) {
            NSLog(@"rar格式的压缩文件需要解压密码");
            return YES;
        }
        return NO;
    }else{
        //判断zip格式的压缩文件是否需要解压密码
        return NO;
    }
}

#pragma mark - Decompressing Methods
- (void)deCompressWithDirectoryName:(NSString*)dirName{
      if ( [_fileType compare:rar options:NSCaseInsensitiveSearch] == NSOrderedSame ) {
          [self rarDecompress:dirName];
      }
      else if ( [_fileType compare:zip options:NSCaseInsensitiveSearch] == NSOrderedSame ) {
          [self zipDecompress:dirName];
      }
      else if ( [_fileType compare:@"7z" options:NSCaseInsensitiveSearch] == NSOrderedSame ) {
          [self decompress7z:dirName];
      }
}

- (void)deCompressWithDirectoryName:(NSString *)dirName password:(NSString *)psd{
    _password = psd;
    if ( [_fileType compare:rar options:NSCaseInsensitiveSearch] == NSOrderedSame ) {
        [self rarDecompress:dirName];
    }
    else if ( [_fileType compare:zip options:NSCaseInsensitiveSearch] == NSOrderedSame ) {
        [self zipDecompress:dirName];
    }
    else if ( [_fileType compare:@"7z" options:NSCaseInsensitiveSearch] == NSOrderedSame ) {
        [self decompress7z:dirName];
    }
}

- (void)rarDecompress:(NSString*)dirName {
    _destinationPath = [_destinationPath stringByAppendingPathComponent:dirName];
    NSLog(@"filePath : %@",_filePath);
    NSLog(@"destinationPath : %@",_destinationPath);

    NSError *archiveError = nil;
    URKArchive *archive = [[URKArchive alloc] initWithPath:_filePath error:&archiveError];
    
    if (!archive) {
        if (self.failureBlock) {
              self.failureBlock();
        }
        return;
    }
    
    NSError *error = nil;
    NSArray *filenames = [archive listFilenames:&error];
    
    if (archive.isPasswordProtected) {
        archive.password = self.password;
    }
    
    if (error) {
        if (self.failureBlock) {
            self.failureBlock();
        }
//        NSLog(@"Error reading archive: %@", error);
//        return;
    }
    
    // Extract a file into memory just to validate if it works/extracts
    [archive extractDataFromFile:filenames[0] error:&error];
    
    if (error) {
        if (error.code == ERAR_MISSING_PASSWORD) {
            NSLog(@"Password protected archive! Please provide a password for the archived file.");
        }
       
        if (self.failureBlock) {
              self.failureBlock();
        }
    }
    else {
        NSMutableArray *filePathsArray = [NSMutableArray array];
        for (NSString *filePath in filenames){
            [filePathsArray addObject:[_destinationPath stringByAppendingPathComponent:filePath]];
        }
        [self moveFilesToDestinationPathFromCompletePaths:filePathsArray withFilePaths:filenames withArchive:archive];
        if (self.completionBlock) {
            self.completionBlock(filePathsArray);
        }
    }
    
}

- (void)zipDecompress:(NSString*)dirName{
    _destinationPath = [_destinationPath stringByAppendingPathComponent:dirName];
    BOOL unzipped = [SSZipArchive unzipFileAtPath:_filePath toDestination:_destinationPath delegate:self];
    
    NSError *error;
    if (self.password != nil && self.password.length > 0) {
        unzipped = [SSZipArchive unzipFileAtPath:_filePath toDestination:_destinationPath overwrite:NO password:self.password error:&error delegate:self];
        NSLog(@"error: %@", error);
    }
    
    if ( !unzipped ) {
        if (self.failureBlock) {
              self.failureBlock();
        }
    }
    
    if (self.completionBlock) {
        self.completionBlock(@[@"asd"]);
    }
}

- (void)decompress7z:(NSString*)dirName{
    _destinationPath = [_destinationPath stringByAppendingPathComponent:dirName];
    NSLog(@"_filePath: %@", _filePath);
    NSLog(@"_destinationPath: %@", _destinationPath);
    
    LzmaSDKObjCReader *reader = [[LzmaSDKObjCReader alloc] initWithFileURL:[NSURL fileURLWithPath:_filePath] andType:LzmaSDKObjCFileType7z];
    
    reader.passwordGetter = ^NSString*(void){
        NSLog(@"self.password: %@", self.password);
        return self.password;
    };
    
    // Open archive, with or without error. Error can be nil.
    NSError * error = nil;
    if (![reader open:&error]) {
        NSLog(@"Open error: %@", error);
    }
    NSLog(@"Open error: %@", reader.lastError);
    
    NSMutableArray *filePathsArray = [NSMutableArray array];

    NSMutableArray * items = [NSMutableArray array]; // Array with selected items.
    // Iterate all archive items, track what items do you need & hold them in array.
    [reader iterateWithHandler:^BOOL(LzmaSDKObjCItem * item, NSError * error){
        if (item) {
            [items addObject:item]; // if needs this item - store to array.
            if (!item.isDirectory) {
                NSString *filePath = [self->_destinationPath stringByAppendingPathComponent:item.directoryPath];
                filePath = [filePath stringByAppendingPathComponent:item.fileName];
                [filePathsArray addObject:filePath];
            }
        }
        return YES; // YES - continue iterate, NO - stop iteration
    }];
    NSLog(@"Iteration error: %@", reader.lastError);
    
    // Extract selected items from prev. step.
    // YES - create subfolders structure for the items.
    // NO - place item file to the root of path(in this case items with the same names will be overwrited automaticaly).
    [reader extract:items
              toPath:_destinationPath
       withFullPaths:YES];
    NSLog(@"Extract error: %@", reader.lastError);
    
    // Test selected items from prev. step.
    [reader test:items];
    NSLog(@"test error: %@", reader.lastError);
    if (reader.lastError || ![filePathsArray count]) {
        failureBlock();
    }
    else {
        self.completionBlock(filePathsArray);
    }
    
}

- (void)compressFileWithCompressType:(NSString*)compressType fileName:(NSString*)fileName{
    if ([compressType isEqualToString:@"rar"]) {
        [self rarCompress:fileName];
    }else{
        [self zipCompress:fileName];
    }
}


/// rar格式压缩
- (void)rarCompress:(NSString*)fileName{
    _destinationPath = [_destinationPath stringByAppendingPathComponent:fileName];

    NSString *originPath = _filePath;
    NSString *destinPath = _destinationPath;
    
    URKArchive *archive = [[URKArchive alloc] initWithPath:originPath error:nil];
    
    
    
}

/// zip格式压缩
- (void)zipCompress:(NSString*)fileName{
    _destinationPath = [_destinationPath stringByAppendingPathComponent:fileName];

    NSString *originPath = _filePath;
    NSString *destinPath = _destinationPath;
    
    BOOL isCompress = [SSZipArchive createZipFileAtPath:destinPath withFilesAtPaths:@[originPath]];
    if (isCompress) {
        if (self.completionBlock) {
            self.completionBlock(@[@"success"]);
        }
    }else{
        if (self.failureBlock) {
            self.failureBlock();
        }
    }
}

#pragma mark - SSZipArchive Delegates
- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath WithFilePaths:(NSMutableArray *)filePaths{
    //    NSLog(@"path : %@",path);
    //    NSLog(@"unzippedPath : %@",unzippedPath);
    if (self.completionBlock) {
        self.completionBlock(filePaths);
    }
}


#pragma mark - Utility Methods
- (NSString *) applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

#pragma mark - Not using these methods now
//Writing this for Unrar4iOS, since it just unrar's(decompresses) the files into the compressed(rar) file's folder path
- (void)moveFilesToDestinationPathFromCompletePaths:(NSArray *)completeFilePathsArray withFilePaths:(NSArray *)filePathsArray withArchive:(URKArchive*)archive{
    
    NSError *error;
    [archive extractFilesTo:_destinationPath overwrite:NO error:&error];
    NSLog(@"Error: %@", error);
}

@end
