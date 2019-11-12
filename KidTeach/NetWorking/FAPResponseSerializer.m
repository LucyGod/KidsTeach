//
//  FAPBaseView.h
//  KidTeach
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPResponseSerializer.h"

@implementation FAPResponseSerializer
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    return self;
}
@end
