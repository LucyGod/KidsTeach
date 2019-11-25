// Copyright 2013 Ziyong Luo
// Use of this file is governed by the Apache License, Version 2.0 that can be found in the LICENSE
// file.

#import "NSString+Path.h"

@implementation NSString (Path)

+ (NSString*)pathForDocumentDirectory {
    static NSString* documentPath = nil;
    if (documentPath == nil) {
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,
                                                             YES);
        documentPath = [paths objectAtIndex:0];
    }
    return documentPath;
}

+ (NSString*)pathForLibraryDirectory {
    static NSString* libraryPath = nil;
    if (libraryPath == nil) {
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                             NSUserDomainMask,
                                                             YES);
        libraryPath = [paths objectAtIndex:0];
    }
    return libraryPath;
}

+ (NSString*)pathForCachesDirectory {
    static NSString* cachesPath = nil;
    if (cachesPath == nil) {
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                             NSUserDomainMask,
                                                             YES);
        cachesPath = [paths objectAtIndex:0];
    }
    return cachesPath;
}

+ (NSString*)pathForTmpDirectory {
    static NSString *tmpPath = nil;
    if (tmpPath == nil) {
        tmpPath = NSTemporaryDirectory();
    }
    return tmpPath;
}

- (NSString *)pathInDocumentDirectory {
    return [[[self class] pathForDocumentDirectory] stringByAppendingPathComponent:self];
}

- (NSString *)pathInLibraryDirectory {
    return [[[self class] pathForLibraryDirectory] stringByAppendingPathComponent:self];
}

- (NSString *)pathInCachesDirectory {
    return [[[self class] pathForCachesDirectory] stringByAppendingPathComponent:self];
}
- (NSString *)pathInTmpDirectory {
    return [[[self class] pathForTmpDirectory] stringByAppendingPathComponent:self];
}
@end
