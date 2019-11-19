//
//  FileSystemCollectionViewCell.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileSystemCollectionViewCell.h"

@implementation FileSystemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self configViews];
}

- (void)configViews{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] init];
    longPress.minimumPressDuration = 1.0;
    [longPress addTarget:self action:@selector(longPressAction)];
    [self.iconImageView addGestureRecognizer:longPress];
}

//长按编辑
- (void)longPressAction{
    
}

- (void)showDeleteIcon{
    
    self.deleteIconButton.transform = CGAffineTransformMakeScale(0, 0);
    self.deleteIconButton.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.deleteIconButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished){
    }];
}

- (void)hideDeleteIcon{
    self.deleteIconButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
    [UIView animateWithDuration:0.3 animations:^{
        self.deleteIconButton.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished){
        self.deleteIconButton.hidden = YES;
    }];
}

- (IBAction)deleteBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickedDeleteButton:)]) {
        [self.delegate didClickedDeleteButton:self];
    }
}

@end
