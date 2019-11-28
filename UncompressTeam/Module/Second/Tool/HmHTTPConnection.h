//
//  HmHTTPConnection.h
//  LDDVideoPro
//
//  Created by MAC on 15/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <HTTPConnection.h>
@class MultipartFormDataParser;
NS_ASSUME_NONNULL_BEGIN

@interface HmHTTPConnection :  HTTPConnection {
    MultipartFormDataParser *parser;
    NSFileHandle *storeFile;
    NSMutableArray *uploadedFiles;
    
}

@end

NS_ASSUME_NONNULL_END
