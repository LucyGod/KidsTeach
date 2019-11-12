//
//  myUILabel.m
//  otv
//
//  Created by 朗月 on 16/11/1.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "myUILabel.h"

@implementation myUILabel

@synthesize verticalAlignment = verticalAlignment_;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        self.verticalAlignment = VerticalAlignmentMiddle;
        //设置字体的颜色、字体大小
        self.font=kFont(14);//默认
            
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
        CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
        switch (self.verticalAlignment) {
            case VerticalAlignmentTop:
                textRect.origin.y = bounds.origin.y;
                break;
            case VerticalAlignmentBottom:
                textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
                break;
            case VerticalAlignmentMiddle:
                // Fall through.
            default:
                textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
        }
    
      return textRect;
}
-(void)drawTextInRect:(CGRect)requestedRect {
    
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
