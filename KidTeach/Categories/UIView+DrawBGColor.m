//
//  UIView+DrawBGColor.m
//  GLKit
//
//  Created by ghostlord on 2017/8/1.
//  Copyright © 2017年 ghostlord. All rights reserved.
//
#import <objc/message.h>

#import "UIView+DrawBGColor.h"
// 随机颜色
#define ColorWithRandom [[UIColor alloc] initWithRed:(arc4random_uniform(255) / 255.0) green:(arc4random_uniform(255) / 255.0) blue:(arc4random_uniform(255) / 255.0) alpha:1.0]

@implementation UIView (DrawBGColor)

/**
 绘制指定颜色的背景
 
 @param color 背景颜色
 @param rect rect
 */
- (void)drawBGWithColor:(UIColor * _Nonnull)color Rect:(CGRect)rect {
    
    if(!color) {
        
        NSAssert(color = nil, @"color should not be nil");
        
        color = [UIColor whiteColor];
    }
    
    // 设置填充颜色
    [color set];
    // 填充图形
    UIRectFill(rect);
}


/**
 绘制渐变背景
 
 @param colors 渐变的颜色
 @param startPoint 开始的点
 @param endPoint 结束渐变的点
 @param context 图形上下文
 备注：startPoint 和 endPoint 共同决定渐变的方向
 */
- (void)drawGradientBGWithColors:(NSArray <UIColor *> * _Nonnull)colors StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint Context:(CGContextRef)context {

    CGPathRef path = [UIBezierPath bezierPathWithRect:self.frame].CGPath;
    
    [self drawGradientBGWithColors:colors CGPath:path StartPoint:startPoint EndPoint:endPoint Context:context Locations:@[@(0.0),@(1.0)]];
    
}

/**
 绘制自定义形状的渐变背景
 
 @param colors 渐变的颜色
 @param path 路径
 @param startPoint 开始的点(view的真实坐标)
 @param endPoint 结束渐变的点(view的真实坐标)
 @param context 图形上下文
 @param locationArray 渐变角度(传入的是NSNumber 的数组，值得范围为0-1)
 备注：startPoint 和 endPoint 共同决定渐变的方向
 */
- (void)drawGradientBGWithColors:(NSArray <UIColor *> * _Nonnull)colors CGPath:(CGPathRef)path StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint Context:(CGContextRef)context Locations:( NSArray <NSNumber *>* _Nullable)locationArray {
    
    
    // 检查颜色是否传入
    if(isArrEmpty(colors)) {
        
        NSAssert(colors.count >= 1, @"colors array's count should more than zero !");
        return;
    }
    
    // 获得颜色空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSMutableArray *cgColors = @[].mutableCopy;
    
    for (int a = 0; a <colors.count; a ++) {
        UIColor *tempColor = colors[a];
        
        [cgColors addObject:(__bridge id)tempColor.CGColor];
    }
    
    // 获得locations
    
    CGFloat locations[] = {0.0,1.0};
    
    if (isArrEmpty(locationArray) || locationArray.count < 2) {
        locationArray = @[@(0.0),@(1.0)];
    }
    
    for (int a = 0; a < locationArray.count; a ++) {
        
        locations[a] = [locationArray[a] floatValue];
    }
    
    // 渐变
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)cgColors, locations);

    CGContextSaveGState(context);
    
    CGContextAddPath(context, path);
    
    CGContextClip(context);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    // 开始绘制
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    // 释放资源
    CGGradientRelease(gradient);
    
    CGColorSpaceRelease(colorSpace);

}

@end
