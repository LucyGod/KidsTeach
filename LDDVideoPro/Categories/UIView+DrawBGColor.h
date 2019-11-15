//
//  UIView+DrawBGColor.h
//  GLKit
//
//  Created by ghostlord on 2017/8/1.
//  Copyright © 2017年 ghostlord. All rights reserved.
//

/**
 绘制UIview背景颜色的类目,需要在drawRect方法中调用
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (DrawBGColor)

/**
 绘制指定颜色的背景

 @param color 背景颜色
 @param rect rect
 */
- (void)drawBGWithColor:(UIColor * _Nonnull)color Rect:(CGRect)rect;


/**
 绘制渐变背景

 @param colors 渐变的颜色
 @param startPoint 开始的点
 @param endPoint 结束渐变的点
 @param context 图形上下文
 备注：startPoint 和 endPoint 共同决定渐变的方向
 */
- (void)drawGradientBGWithColors:(NSArray <UIColor *> * _Nonnull)colors StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint Context:(CGContextRef)context;

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
- (void)drawGradientBGWithColors:(NSArray <UIColor *> * _Nonnull)colors CGPath:(CGPathRef)path StartPoint:(CGPoint)startPoint EndPoint:(CGPoint)endPoint Context:(CGContextRef)context Locations:( NSArray <NSNumber *>* _Nullable)locationArray;

@end

NS_ASSUME_NONNULL_END
