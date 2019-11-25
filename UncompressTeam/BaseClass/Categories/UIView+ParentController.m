//
//  UIView+ParentController.m
//  AUTO360
//
//  Created by langyue on 16/3/18.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "UIView+ParentController.h"

@implementation UIView (ParentController)


- (UIViewController *)parentController
{
    UIResponder *responder = [self nextResponder];
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = [responder nextResponder];
    }
    return nil;
}



@end
