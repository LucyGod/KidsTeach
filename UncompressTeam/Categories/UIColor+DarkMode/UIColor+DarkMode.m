//
//  UIColor+DarkMode.m
//  EEEStockProject
//
//  Created by Mac on 2019/9/23.
//  Copyright © 2019 ASO. All rights reserved.
//

#import "UIColor+DarkMode.h"

@implementation UIColor (DarkMode)

/// 配置动态颜色
/// @param lightColor light mode color
/// @param darkColor dark mode color
+ (UIColor *)dy_lightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    UIColor *color = lightColor;
    
    if (@available(iOS 13.0, *)) {
        color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            }else {
                return lightColor;
            }
        }];
    }
    return color;
}

/// 配置16进制动态颜色
/// @param lightHexColor light mode hex color
/// @param darkHexColor dark mode hex color
+ (UIColor *)dy_lightHexColor:(int)lightHexColor darkHexColor:(int)darkHexColor {
    UIColor *color = [UIColor gl_hex:lightHexColor];
    
    if (@available(iOS 13.0, *)) {
        color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [UIColor gl_hex:darkHexColor];
            }else {
                return [UIColor gl_hex:lightHexColor];
            }
        }];
    }
    return color;
}

/// 16进制颜色转UIColor
/// @param hexColor 16进制颜色
+ (UIColor *)gl_hex:(int)hexColor {
    return [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16)) / 255.0 green:((float)((hexColor & 0xFF00) >> 8)) / 255.0 blue:((float)(hexColor & 0xFF)) / 255.0 alpha:1.0f];
}

@end
