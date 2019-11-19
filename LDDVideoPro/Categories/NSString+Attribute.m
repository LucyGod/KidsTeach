//
//  NSString+Attribute.m
//  ASO
//
//  Created by walker on 2018/6/28.
//  Copyright © 2018年 ASO. All rights reserved.
//

#import "NSString+Attribute.h"

@implementation NSString (Attribute)

/**
 将当前字符串根据条件生成一个简单的属性字符串
 
 @param font 字体
 @param color 字体颜色
 @return 属性字符串
 */
- (NSAttributedString *)gl_createAttributedStringWithFont:(UIFont * _Nullable)font textColor:(UIColor *_Nullable)color {
    
    NSString *tempStr = isStrEmpty(self) ? @"" : [self copy];
    UIFont *tempFont = font ? : [UIFont systemFontOfSize:17.0f];
    UIColor *tempColor = color ? : [UIColor blackColor];
    
    return [[NSAttributedString alloc] initWithString:tempStr attributes:@{NSFontAttributeName:tempFont,NSForegroundColorAttributeName:tempColor}];
}

- (CGFloat)getHeightWithWidth:(CGFloat)width fontSize:(CGFloat)fontSize {
    
    CGRect textSize = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont kk_systemFontOfSize:fontSize]} context:nil];
    return textSize.size.height;
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    resultSize = [self boundingRectWithSize:size
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font}
                                    context:nil].size;
    resultSize = CGSizeMake(MIN(size.width, ceilf(resultSize.width)), MIN(size.height, ceilf(resultSize.height)));
    return resultSize;
}

@end
