//
//  UIResponder+responder.m
//  FoJiao
//
//  Created by 李震 on 2017/4/18.
//  Copyright © 2017年 ZSC. All rights reserved.
//

#import "UIResponder+responder.h"

@implementation UIResponder (responder)


- (void)responderWithName:(NSString *)name userInfo:(NSDictionary *)info
{
    [[self nextResponder] responderWithName:name userInfo:info];
}

@end
