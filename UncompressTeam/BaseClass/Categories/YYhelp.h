//
//  YYhelp.h
//  cloudshang
//
//  Created by 高燕 on 2019/7/15.
//  Copyright © 2019 gaoyan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LYBaseScreen ([[UIScreen mainScreen] bounds].size.width / 320.0f)

#define LYLog(...) NSLog(__VA_ARGS__);
#define LYLog_METHOD NSLog(@"%s", __func__);


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YYhelp : NSObject

+(BOOL)isPassword:(NSString *)paw;
//校验密码6-20字母数字特殊字符
+(BOOL)isLegitimatePassword:(NSString *)paw;
//校验手机号
+(BOOL)isJudgeUserPhone:(NSString *)mobile;
//校验搜索信息为(字母数字和汉字组成)
+(BOOL)isJudgeSearchText:(NSString *)searchText;
+(BOOL)isVaildatePhone:(NSString *)phone;
+(BOOL)isVaildateData:(NSString *)data;//验证码4-6位

+(NSInteger)statusNetwork;

+(NSString *)getNetWorkStates;

+ (NSString *)GetUUID;
+(NSString *)flattenHTML:(NSString *)html;
+ (void)callPhone:(NSString *)phone;
+(NSString *)weekChinese;
+ (NSString *)monthChinese;
+ (NSString *)dayChinese;
+ (NSString *)dateTime:(NSString *)dateStr;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSDate *)dateFromString:(NSString *)dateString;
+(NSString*)getIdentificationBirthdayDate:(NSString*)carId;
+(NSString*)writeDocumnetImage:(UIImage*)image;
+(NSString *)getPathFromProject:(NSString *)fileName;
+ (void)showAlertWithTitle:(NSString *)title Message:(NSString *)message;


@end


@interface NSString(FontApi)

-(CGSize)lyFont:(UIFont *)font constrainedSize:(CGSize)size;
@end

@interface UIView (DaDView)
@property(nonatomic) CGFloat leftD;
@property(nonatomic) CGFloat rightD;
@property(nonatomic) CGFloat topD;
@property(nonatomic) CGFloat bottomD;
@property(nonatomic) CGFloat widthD;
@property(nonatomic) CGFloat heightD;
@property(nonatomic) CGFloat centerXD;   //中心点X
@property(nonatomic) CGFloat centerYD;   //
@property(nonatomic) CGPoint originD;
@property(nonatomic) CGSize sizeD;
@property(nonatomic) CGRect frameD;
@property(nonatomic) CGFloat RBY;
@end

float h(float h);
BOOL isNetLink();

int textLength(NSString *text);

BOOL validateNumber(NSString *number);

BOOL isMobileNumber(NSString *mobileNum);

BOOL isHKMobileNumber(NSString *mobileNum);

BOOL validateEmail(NSString *str);

BOOL validatePwd(NSString *str);

//简单判定是否为身份证号
BOOL validateIdentityCard1(NSString *identityCard);

BOOL validateIdentityCard(NSString *cardID);

BOOL stringIsNil(NSString *string);

BOOL dictValidateObj(id obj);

BOOL aryValidateObj(id obj);

BOOL nullObject(id obj);


BOOL validateString(id obj);


NSString *cachesPath(NSString *fileName);
NSString *bundlePath(NSString *fileName);


BOOL haveCachesFile(NSString * fileName);
BOOL createCachesFolder(NSString *folderName);
BOOL removeCachesFolder(NSString *folderName);


UIFont *lyFont(CGFloat fontValue);
UIFont *lyTitleFont(CGFloat fontValue);
UIFont *lyFontA(NSString *fontName,CGFloat fontValue);


UIColor *lyColor(CGFloat colorValue);
UIColor *lyColorA(CGFloat colorValue,CGFloat a);
UIColor *lyColorRGB(CGFloat r,CGFloat b,CGFloat g);
UIColor *lyColorRGBA(CGFloat r,CGFloat b,CGFloat g,CGFloat a);



int sizeFromPath(NSString *folderPath);
NSString *sizeStringFormPath(NSString *folderPath);


#pragma mark==========================多颜色或多字体=============================
NSMutableAttributedString *multipleColor(UIColor *color,NSRange range,NSAttributedString *string);
NSMutableAttributedString *multipleFont(UIFont *font,NSRange range,NSAttributedString *string);


