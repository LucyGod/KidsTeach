//
//  ASOConstants.h
//  LDDVideoPro
//
//  Created by Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+DarkMode.h"

/// ------- API 相关 ---------
#define APIBaseURL_juhe                             [ASOServerManager manager].optimalServer.baseApiUrl_juhe
#define APIKey_juhe                                 [ASOServerManager manager].optimalServer.appkey_juhe
#define APIBaseURL_51                               [ASOServerManager manager].optimalServer.baseApiUrl_51
#define APIKey_51                                   [ASOServerManager manager].optimalServer.appkey_51
#define APIBaseURL_jisu                             [ASOServerManager manager].optimalServer.baseApiUrl_jisu
#define APIKey_jisu                                 [ASOServerManager manager].optimalServer.appkey_jisu

/// ----- 测试账号 ----
#define TestAccount                                 @"13212341234"
#define TestPsd                                     @"123456"

// ------ 字体样式 ----------
#define fFont @"EuphemiaUCAS"
#define kFont(Size) [UIFont systemFontOfSize:Size]
#define kImage(Name) [UIImage imageNamed:Name]


// ------ 公共字符串 -----
#define NetErrorTipString @"网络繁忙，请稍后重试"
#define NoDataAndTouchRefresh @"当前无数据，请点击重试"

// ----------- 公共尺寸 ------
/* 屏幕宽 */
#define SCREEN_Width   ([UIScreen mainScreen].bounds.size.width)
/* 屏幕高 */
#define SCREEN_Height  ([UIScreen mainScreen].bounds.size.height)
/* 最大的长度 */
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
/* 最小的长度 */
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

// --------- 适配公共宏 ------
/** 控件缩放比例，按照宽度计算 */
#define SCALE_Length(l) (IS_PORTRAIT ? round((SCREEN_Width/375.0*(l))) : round((SCREEN_Width/667.0*(l))))

/** 是否是异形屏 */
#define IS_HETERO_SCREEN (ASO_iPhone_X || ASO_iPhone_X_Max)

/** 是否是竖屏 */
#define IS_PORTRAIT (([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown))
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

// -- 导航栏和Tabbar针对iPhone X 的适配  --
#define Nav_topH (IS_HETERO_SCREEN ? 88.0 : 64.0)
#define Tab_H (IS_HETERO_SCREEN ? 83.0 : 49.0)
#define NavMustAdd (IS_HETERO_SCREEN ? 34.0 : 0.0)
#define TabMustAdd (IS_HETERO_SCREEN ? 20.0 : 0.0)
#define Status_H  (IS_HETERO_SCREEN ? 44.0 : 20.0)
#define NavigationItem_H   (44.0)
#define ASOStatue_Height (float)([[UIApplication sharedApplication] statusBarFrame].size.height)
#define ASONavBar_height (float)(ASOStatue_Height +44.0f)

// 防空判断 ------------
/** 字符串防空判断 */
#define isStrEmpty(string) (string == nil || string == NULL || (![string isKindOfClass:[NSString class]]) || ([string isEqual:@""]) || [string isEqualToString:@""] || [string isEqualToString:@" "] || ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0))
/* 返回一个非空的字符串 */
#define STRINGNOTNIL(string) isStrEmpty(string) ? @"" : string

/** 数组防空判断  */
#define isArrEmpty(array) (array == nil || array == NULL || (![array isKindOfClass:[NSArray class]]) || array.count == 0)
/** 字典防空判断 */
#define isDictEmpty(dict) (dict == nil || dict == NULL || (![dict isKindOfClass:[NSDictionary class]]) || dict.count == 0)

// ---- 颜色创建宏 -----
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define LINECOLOR                               HexColor(0xe5e5e5)
#define HexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#define HexAlphaColor(hexValue, alpha) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:alpha]

#define ClearColor [UIColor clearColor]
// 随机色
#define RandomColor RGBColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

// 项目中主要颜色的定义
#define ASOColorTheme                           HexColor(0x2CB4DC)     // 主题颜色
#define APPColor ASOColorTheme

#define ASOColorLong                            HexColor(0x28A351)     // 上涨颜色(绿色)
#define ASOColorShort                           HexColor(0xcc3366)     // 下跌颜色(红色)
#define ASOColorKlineBG                          RGBColor(33, 33, 39)
#define ASOColorLongBG                           HexColor(0xEDF7EB)//
#define ASOColorShortBG                         HexColor(0xFDE7EE)      // 下跌背景颜色(绿色背景)
#define ASOColorTitle                           HexColor(0x333333)     // 用于主要文字提示，标题，重要文字
#define ASOColorNormalText                      HexColor(0x666666)     // 正常字体颜色，二级文字，标签栏
#define ASOColorTipText                         HexColor(0xB4B4B4)     // 提示文字，提示性文字，重要级别较低的文字信息
#define ASOColorBorder                          HexColor(0xcccccc)     // 边框颜色，提示性信息
#define ASOColorSeparator                       HexColor(0xeeeeee)     // 分割线颜色，宽度1像素
#define ASOColorGap                             HexColor(0xF8F8F8)     // 背景间隔色彩
#define ASOColorBackGround                      HexColor(0xf7f7f7)    // 白色背景色HexColor(0xf7f7f7)
#define ASOColorText_000000                     HexColor(0x000000)     // 黑色背景色
#define ASOColorAlert_f8f8f8                    HexColor(0xf8f8f8)     // 首页收藏视图弹框颜色
#define ASOColorWarning                         HexColor(0xFA0000)     // 警告颜色
#define ASOColorMarketDetail                    HexColor(0xffffff)      // 行情详情页背景
#define ASOColorMarketDetailsBG                 ASOColorKlineBG
//背景透明色
#define ASOColorAlert_BGColor                   HexAlphaColor(0x000000,0.4)
#define GrayTextColor DYUIColor(APPGrayColor, RGBCOLOR(22, 22, 22))
#define GrayBACKColor DYUIColor(APPGrayColor, RGBCOLOR(35, 35, 35))
#define APPGrayColor RGBCOLOR(242, 242, 242)

#define TextColor DYUIColor(RGBCOLOR(101, 101, 111), RGBCOLOR(250, 250, 250))


#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KGray2Color [UIColor lightGrayColor]
#define KBlueColor [UIColor blueColor]
#define KRedColor [UIColor redColor]
#define kWhiteColor [UIColor whiteColor]
#define CLEARCOLOR [UIColor clearColor]

#define C333 RGBColor(51, 51, 51)
#define C666 RGBColor(102, 102, 102)
#define C999 RGBColor(153, 153, 153)
#define DefaultRedColor RGBColor(207, 76, 102)
#define DefaultGreenColor RGBColor(27, 157, 123)
#define kTabBarBackgroundColor RGBColor(19, 29, 50)

#define FDefaultFont14 [UIFont systemFontOfSize:14.0f]
#define FDefaultFont16 [UIFont systemFontOfSize:16.0f]




// 手机尺寸型号
#define ASO_iPhone_4x        (SCREEN_Width == 320 && SCREEN_Height == 480)
#define ASO_iPhone_5x        (SCREEN_Width == 320 && SCREEN_Height == 568)
#define ASO_iPhone_6x        (SCREEN_Width == 375 && SCREEN_Height == 667)
#define ASO_iPhone_plus      (SCREEN_Width == 414 && SCREEN_Height == 736)
#define ASO_iPhone_X         (SCREEN_Width == 375 && SCREEN_Height == 812)   // iPhone X,    iPhone XS
#define ASO_iPhone_X_Max     (SCREEN_Width == 414 && SCREEN_Height == 896)   // iPhone XR,   iPhone XS Max

#define WHITECOLOR DYUIColor(KBlackColor,kWhiteColor)

#define NAVIGATION_BAR_HEIGHT (Screen_Height>=812 ? 88.f : 64.f)// 导航栏高度
#define kScreenWidth   [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight  [[UIScreen mainScreen]bounds].size.height
#define ScreenHeight   [UIScreen mainScreen].bounds.size.height
#define Screen_Height  ([UIScreen mainScreen].bounds.size.height)
#define kTabBarHeight (CGFloat)(Screen_Height>=812?(49.0 + 34.0):(49.0))


// weak/strong self ----------
#define WEAKSELF  typeof(self) __weak weakSelf=self;
#define weakSelf(ref)           __weak __typeof(ref)weakSelf = ref;
#define strongSelf(weakRef)     __strong __typeof(weakRef)strongSelf = weakRef;

// 通知用到的key -----
#define ASO_NotificationKey_NeedLogIn       @"ASO_NotificationKey_NeedLogIn"
#define ASO_NotificationKey_DidLogIn        @"ASO_NotificationKey_DidLogIn"
#define ASO_NotificationKey_NeedLogOut      @"ASO_NotificationKey_NeedLogOut"
#define ASO_NotificationKey_DidLogOut       @"ASO_NotificationKey_DidLogOut"

// 公共代码 --- 用作代码混淆 --
#define BBCMIXFUNC -(void)p_mixFunc {   \
NSString *string = [NSString stringWithFormat:@"%s--%s",__FILE__,__func__];\
if (string) {\
    string = [string stringByAppendingString:@"asjglarghjkasdi12335ljfgl"];\
    }\
}\
\


/** 字符串防空判断 */
#define XSY_isStrEmpty(string) (string == nil || string == NULL || (![string isKindOfClass:[NSString class]]) || ([string isEqual:@""]) || [string isEqualToString:@""] || [string isEqualToString:@" "] || ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0))


/** 系统Document文件夹路径*/
#define DocumentsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

////测试Key
//#define BaseADAPPID @"ca-app-pub-6864430072527422~9932626301"
////banner
//#define BannerADID @"ca-app-pub-6864430072527422/1557983277"
////插屏广告
//#define InteredADID @"ca-app-pub-6864430072527422/7931819933"
////原生广告
//#define NomalADID @"ca-app-pub-6864430072527422/8044829565"
////激励广告
//#define GULIADID @"ca-app-pub-6864430072527422/3992574922"


//测试Key
#define BaseADAPPID @"ca-app-pub-~9932626301"
//banner
#define BannerADID @"ca-app-pub-/1557983277"
//插屏广告
#define InteredADID @"ca-app-pub-/7931819933"
//原生广告
#define NomalADID @"ca-app-pub-/8044829565"
//激励广告
#define GULIADID @"ca-app-pub-/3992574922"
