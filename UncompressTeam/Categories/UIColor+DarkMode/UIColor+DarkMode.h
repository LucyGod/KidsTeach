//
//  UIColor+DarkMode.h
//  EEEStockProject
//
//  Created by Mac on 2019/9/23.
//  Copyright © 2019 ASO. All rights reserved.
//

/**
 动态颜色配置
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 动态【16进制】颜色配置
#define DYHexColor(light_hexColor, dark_hexColor) [UIColor dy_lightHexColor:light_hexColor darkHexColor:dark_hexColor]
// 动态普通颜色配置
#define DYUIColor(light_Color, dark_Color) [UIColor dy_lightColor:light_Color darkColor:dark_Color]

@interface UIColor (DarkMode)

/// 配置动态颜色
/// @param lightColor light mode color
/// @param darkColor dark mode color
+ (UIColor *)dy_lightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

/// 配置16进制动态颜色
/// @param lightHexColor light mode hex color
/// @param darkHexColor dark mode hex color
+ (UIColor *)dy_lightHexColor:(int)lightHexColor darkHexColor:(int)darkHexColor;

/// 16进制颜色转UIColor
/// @param hexColor 16进制颜色
+ (UIColor *)gl_hex:(int)hexColor;
@end

NS_ASSUME_NONNULL_END
