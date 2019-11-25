// Copyright 2013 Ziyong Luo
// Use of this file is governed by the Apache License, Version 2.0 that can be found in the LICENSE
// file.

#import <Foundation/Foundation.h>

@interface NSString (Path)

+ (NSString*)pathForDocumentDirectory;
+ (NSString*)pathForLibraryDirectory;
+ (NSString*)pathForCachesDirectory;
+ (NSString*)pathForTmpDirectory;

// Retrieve the absolute path by append self to the Document/Library/Caches directory.
- (NSString*)pathInDocumentDirectory;
- (NSString*)pathInLibraryDirectory;
- (NSString*)pathInCachesDirectory;
- (NSString*)pathInTmpDirectory;
@end
