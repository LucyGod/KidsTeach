//
//  MusicModel.m
//  KidTeach
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqual:@""]) {
        
    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}
@end
