//
//  YSEVFontAndColorMacros.h
//  KuaiHaoSheng
//
//  Created by  on 2018/3/18.
//  Copyright © 2018年. All rights reserved.
//

//字体大小和颜色配置

#ifndef YSEVFontAndColorMacros_h
#define YSEVFontAndColorMacros_h

#pragma mark -  间距区
//默认间距
#define KNormalSpace 3.0f
#define RGB0X(rgbValue)     [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
//#define RGBColor(r , g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0 ]


//随机色生成
#define kRandomColor  KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)

#pragma mark -  字体区

#define FSmallFont10 [UIFont systemFontOfSize:10.0f]
#define FSmallFont12 [UIFont systemFontOfSize:12.0f]
#define FDefaultFont14 [UIFont systemFontOfSize:14.0f]
#define FDefaultFont15 [UIFont systemFontOfSize:15.0f]
#define FDefaultFont16 [UIFont systemFontOfSize:16.0f]
#define FDefaultFont18 [UIFont systemFontOfSize:18.0f]

#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
//#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

#pragma mark -  颜色区
//主题色 导航栏颜色
#define CNavBgColor [UIColor colorWithHexString:@"0F1724"]
//#define CNavBgFontColor  [UIColor colorWithHexString:@"FFFFFF"]
#define CTabbarColor  [UIColor colorWithHexString:@"0F1724"]
#define CTabbarSelTitleColor RGB(53, 142, 232)
#define CTabbarNormalTitleColor RGB(48, 63, 89)

//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"09121B"]
//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"eeeeee"]
//次级字色
#define CFontColor1 [UIColor colorWithHexString:@"1f1f1f"]
//再次级字色
#define CFontColor2 [UIColor colorWithHexString:@"5c5c5c"]

#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]

//主要颜色
//#define C333 RGBColor(51, 51, 51,1.0)
//#define C666 RGBColor(102, 102, 102,1.0)
//#define C999 RGBColor(153, 153, 153,1.0)
//#define BACK_GRAYCOLOR RGBColor(243, 244, 245,1.0)
//#define DefaultBuleCOLOR RGBColor(27, 157, 123,1.0)
//#define DefaultRedColor RGBColor(207, 76, 102,1.0)
//
//#define DefaultGreenColor RGBColor(27, 157, 123,1.0)
//#define DefaultGRAYCOLOR RGBColor(245, 245, 245,1.0)
//#define DefaultLIGHTGRAYCOLOR RGBColor(240, 240, 240,0.5)
//
//#define ChangeGradColor1 RGBColor(214, 24,39,1.0)
//#define ChangeGradColor2 RGBColor(251, 95,92,1.0)
//
//#define ChangeGradColor3 RGBColor(253,170,44,1.0)
//#define ChangeGradColor4 RGBColor(253, 205,55,1.0)
//
//#define kRiseRedBGColor    RGBColor(242, 73, 87, 0.08)
//#define kFallGreenBGColor  RGBColor(29, 191, 96, 0.08)


// ----------- 防空判断 ------------------
/** 字符串防空判断 */
#define isStrEmpty(string) (string == nil || string == NULL || (![string isKindOfClass:[NSString class]]) || ([string isEqual:@""]) || [string isEqualToString:@""] || [string isEqualToString:@" "] || ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0))

/** 数组防空判断 */
#define isArrEmpty(array) (array == nil || array == NULL || (![array isKindOfClass:[NSArray class]]) || array.count == 0)

/** 字典防空判断 */
#define isDictEmpty(dict) (dict == nil || dict == NULL || (![dict isKindOfClass:[NSDictionary class]]) || dict.count == 0)

// --------- 适配公共宏 ------
/** 控件缩放比例，按照宽度计算(四舍五入) */
//#define SCALE_Length(l) (IS_PORTRAIT ? round((SCREEN_WIDTH/375.0*(l))) : round((SCREEN_WIDTH/667.0*(l))))
//
///** 是否是异形屏 */
//#define IS_HETERO_SCREEN (GL_iPhone_X || GL_iPhone_X_Max)

/** 是否是竖屏 */
#define IS_PORTRAIT (([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown))

// ------- RGB color 转换 ---------------
/* 根据RGB获得颜色值 */
#define kColorRGB(r , g , b) kColorRGBA(r , g , b ,1.0f)

/* 根据RGB和alpha值获得颜色 */
#define kColorRGBA(r , g , b ,a) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)])

// ------ 导航栏和Tabbar针对iPhone X 的适配  ------
//#define Nav_topH (IS_HETERO_SCREEN ? 88.0 : 64.0)
//#define Tab_H (IS_HETERO_SCREEN ? 83.0 : 49.0)
//#define NavMustAdd (IS_HETERO_SCREEN ? 34.0 : 0.0)
//#define TabMustAdd (IS_HETERO_SCREEN ? 20.0 : 0.0)
//#define StatusBar_H  (IS_HETERO_SCREEN ? 44.0 : 20.0)
//#define NavigationItem_H   (44.0)

// -------- 尺寸  --------------------
/* 屏幕宽 */
//#define SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)
//
///* 屏幕高 */
//#define SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)

// --------- 手机尺寸型号 --------
//#define GL_iPhone_4x        (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 480)
//#define GL_iPhone_5x        (SCREEN_WIDTH == 320 && SCREEN_HEIGHT == 568)
//#define GL_iPhone_6x        (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 667)
//#define GL_iPhone_plus      (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 736)
//#define GL_iPhone_X         (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812)   // iPhone X,    iPhone XS
//#define GL_iPhone_X_Max     (SCREEN_WIDTH == 414 && SCREEN_HEIGHT == 896)   // iPhone XR,   iPhone XS Max


// ---------- 版本号相关 ---------
/* 当前版本号 */
#define OSVERSION ([[UIDevice currentDevice].systemVersion floatValue])

//#define KMarketDetailViewBGColor           [UIColor colorWithHexString:@"09121B"]             //期货详情view背景色

// ---------- 常用颜色 -----------
//#define KColorTheme                        KMarketDetailViewBGColor     // 主题颜色
////#define KColorLong                         [UIColor colorWithHex:0xE70F56]      // 上涨颜色
////#define KColorShort                        [UIColor colorWithHex:0x4FB336]     // 下跌颜色
////#define KColorLongBG                       [UIColor colorWithHex:0xEDF7EB]     // 上涨背景颜色
////#define KColorShortBG                      [UIColor colorWithHex:0xFDE7EE]     // 下跌背景颜色
//#define KColorTitle_333                    [UIColor colorWithHex:0x333333]     // 用于主要文字提示，标题，重要文字
//#define KColorNormalText_666               [UIColor colorWithHex:0x666666]     // 正常字体颜色，二级文字，标签栏
//#define KColorTipText_999                  [UIColor colorWithHex:0x999999]     // 提示文字，提示性文字，重要级别较低的文字信息
////#define KColorBorder_ccc                   [UIColor colorWithHex:0xcccccc]     // 边框颜色，提示性信息
//#define KColorSeparator_eee                [UIColor clearColor]//[UIColor colorWithHex:0xeeeeee]     // 分割线颜色，宽度1像素
////#define KColorGap                          [UIColor colorWithHex:0xf9f9f9]     // 背景间隔色彩
//#define KColorBackGround                   KMarketDetailViewBGColor     // 白色背景色
//#define KColorText_000000                  [UIColor colorWithHex:0x000000]     // 黑色

//#define UICOLORFROMRGB(rgbValue) [UIColor \
//colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
//green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
//blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#endif /* YSEVFontAndColorMacros_h */
