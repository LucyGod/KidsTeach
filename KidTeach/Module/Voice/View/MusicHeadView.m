//
//  MusicHeadView.m
//  KidTeach
//
//  Created by mac on 2019/11/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "MusicHeadView.h"
#import "UIResponder+responder.h"

@implementation MusicHeadView
- (IBAction)close:(id)sender {
    [self responderWithName:@"headView" userInfo:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
