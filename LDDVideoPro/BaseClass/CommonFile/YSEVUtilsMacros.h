//
//  define.h
//  KuaiHaoSheng
//
//  Created by  on 2018/3/18.
//  Copyright © 2018年. All rights reserved.
//

// 全局工具类宏定义

#ifndef define_h
#define define_h

//适配宏
#define HeightRealValue(value) ((value/1334.0)*ScreenHeight)
#define WidthRealValue(value) ((value/750.0)*ScreenWidth)
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)

//获取系统对象
#define kApplication        [UIApplication sharedApplication]
#define kAppWindow          [UIApplication sharedApplication].delegate.window
#define kAppDelegate        [UIApplication sharedApplication].delegate
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define kUserDefaults       [NSUserDefaults standardUserDefaults]
#define kNotificationCenter [NSNotificationCenter defaultCenter]

//获取屏幕宽高
#define KScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define LYWIDTH  [UIScreen mainScreen].bounds.size.width
#define LYHEIGHT [UIScreen mainScreen].bounds.size.height
#define kScreen_Bounds [UIScreen mainScreen].bounds

//====首页设置
#define kHome_Cell 120
#define kHome_SelectCell 200
#define kHome_ChannelHeight 100
#define kHome_StockHeight 130

#define kChat_ToolHeight 50
#define kChat_ChatDefaultWidth (KScreenWidth-30-40*2-30)


#pragma mark - ------------------- XIB --------------------

#define XIB(Class) [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([Class class]) owner:nil options:nil] firstObject]

#define kCompetionHandleBlock (void(^)(id model, NSError *error))completionHandle;

// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size): NO)

#define IS_IPHONE_Xr2 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size): NO)

//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size): NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size): NO)

//判断6以下的手机
#define IS_IPHONE_5 (SCREEN_MAX_LENGTH <= 568.0)

//home indicator
#define HOME_INDICATOR_HEIGHT ((iPhoneX==YES || IS_IPHONE_Xr ==YES||IS_IPHONE_Xr2==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 34.f : 0.f)

#define  kTabbarSafeBottomMargin ((iPhoneX==YES|| IS_IPHONE_Xr ==YES||IS_IPHONE_Xr2==YES || IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 34.f : 0.f)

//status状态栏高度
#define STATUS_BAR_HEIGHT ((iPhoneX==YES || IS_IPHONE_Xr ==YES ||IS_IPHONE_Xr2==YES|| IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 44.f : 20.f)
//nav导航栏高度
#define NAVIGATION_BAR_HEIGHT ((iPhoneX==YES || IS_IPHONE_Xr ==YES ||IS_IPHONE_Xr2==YES|| IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 88.f : 64.f)
//tabBar高度
#define TAB_BAR_HEIGHT ((iPhoneX==YES || IS_IPHONE_Xr ==YES ||IS_IPHONE_Xr2==YES|| IS_IPHONE_Xs== YES || IS_IPHONE_Xs_Max== YES) ? 83.0 : 49.f)

//根据ip6的屏幕来拉伸
#define SCALE_W(x)  x * KScreenWidth/375.0
#define SCALE_H(x)  x * KScreenHeight/667.0
#define kRealValue(with) ((with)*(KScreenWidth/375.0f))

//强弱引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type) __strong typeof(type) type = weak##type;

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//获取系统版本
#define IOS_Version [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])



//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]
//定义UIImage对象
#define ImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]
#define IMAGE_NAMED(name) [UIImage imageNamed:name]
//数据验证
#define StrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define SafeStr(f) (StrValid(f) ? f:@"")
#define HasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define ValidStr(f) StrValid(f)
#define ValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define ValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define ValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define ValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define ValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

//获取一段时间间隔
#define kStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define kEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)
//打印当前方法名
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)


//发送通知
#define KPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//单例化一个类
#define SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#define MJWeakSelf __weak typeof(self) weakSelf = self;
#define kWidth          [UIScreen mainScreen].bounds.size.width
#define kHeight         [UIScreen mainScreen].bounds.size.height
#define kSize(a)        ceil((a)*([UIScreen mainScreen].bounds.size.width/375.0))
#define kCompetionHandleBlock (void(^)(id model, NSError *error))completionHandle;

#endif /* define_h */
