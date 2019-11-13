//
//  ASOCustomButton.m
//  KidTeach
//
//  Created by MAC on 13/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ASOCustomButton.h"

@implementation ASOCustomButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor colorWithHexString:@"6b6b6b"] forState:UIControlStateNormal];
        
        
    }
    return self;
}


//取消按钮的高亮状态
- (void)setHighlighted:(BOOL)highlighted
{
}
////重写这个方法（调整标签标题的位置）
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake(ZPScreenWidth/3-contentRect.size.width/2, contentRect.size.height-7, contentRect.size.width, 12);
//}
////调整图片位置
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    return CGRectMake((ZPScreenWidth/5-44)/2, 7, 44, 44);
//}


-(void)layoutSubviews {
    [super layoutSubviews];
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2;
    center.y = self.imageView.frame.size.height/2+10;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + 15;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
