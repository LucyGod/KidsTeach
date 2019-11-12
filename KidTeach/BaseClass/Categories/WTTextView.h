//
//  WTTextView.h
//  JSM-CU-iPhone-HD
//
//  Created by mac on 15/6/21.
//  Copyright (c) 2015年 wangtiansoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTTextView : UITextView

@property(nonatomic, strong) UILabel *placeHolderLabel;
@property(nonatomic, strong) NSString *placeholder;
@property(nonatomic, strong) UIColor *placeholderColor;

- (void)textChanged:(NSNotification *)notification;

@end
