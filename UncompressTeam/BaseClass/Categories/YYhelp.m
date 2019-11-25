//
//  YYhelp.m
//  cloudshang
//
//  Created by 高燕 on 2019/7/15.
//  Copyright © 2019 gaoyan. All rights reserved.
//

#import "YYhelp.h"
#import <unistd.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <netdb.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "Reachability.h"

@implementation YYhelp

+(BOOL)isVaildatePhone:(NSString *)phone{
    
    NSString *regxStr=@"[0-9]{11}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regxStr];
    
    if([pred evaluateWithObject:phone]){
        
        return YES;
        
    }else{
        
        return NO;
    }
}
+(BOOL)isVaildateData:(NSString *)data{
    
    NSString *regxStr=@"[0-9]{1,6}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regxStr];
    
    if([pred evaluateWithObject:data]){
        
        return YES;
        
    }else{
        
        return NO;
    }
}
//检测密码是否合法:(6~12个字符,可纯数字或纯字母)
+(BOOL)isLegitimatePassword:(NSString *)paw{
    
    NSString *pw=@"^[0-9A-Za-z@/.,?!&:;¥%$]{6,20}$";
    
    NSPredicate *password=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pw];
    
    if (([password evaluateWithObject:paw])) {
        
        return YES;
        
    }else {
        return NO;
    }
    
}
//检测密码是否合法:(6~12个字符,可纯数字或纯字母)
+(BOOL)isPassword:(NSString *)paw{
    
    NSString *pw=@"^[0-9A-Za-z@/.,?!&:;¥%$]*$";
    
    NSPredicate *password=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pw];
    
    if (([password evaluateWithObject:paw])) {
        
        return YES;
        
    }else {
        return NO;
    }
}
//判断手机号
+(BOOL)isJudgeUserPhone:(NSString *)mobile{
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
            
        }else{
            
            return NO;
        }
    }
    
}
//校验搜索信息为(字母数字和汉字组成)
+(BOOL)isJudgeSearchText:(NSString *)searchText{
    
    NSString *regex = @"^[a-zA-Z0-9\u4e00-\u9fa5]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if([pred evaluateWithObject:searchText]){
        
        return YES;
        
    }else{
        
        return NO;
        
    }
}
+(NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state = @"2G";
                    break;
                case 2:
                    state = @"3G";
                    break;
                case 3:
                    state = @"4G";
                    break;
                case 5:
                {
                    state = @"WIFI";
                }
                    break;
                default:
                    break;
            }
        }
    }
    //根据状态选择
    return state;
}
+(NSInteger)statusNetwork{
    
    //检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    //检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    //判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { //有wifi
        
        return 1;
        
    } else if ([conn currentReachabilityStatus] != NotReachable) { //手机网络2g3g4g
        return 2;
        
    } else {//没有网络
        
        return 0;
    }
}
+ (NSString *)GetUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL,uuidRef);
    CFRelease(uuidRef);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuidStringRef];
    CFRelease(uuidStringRef);
    return uuid;
    
    /*
     * 或者使用这种方式释放内存
     
     NSString *uuid = [NSString stringWithString:(__bridge_transfer NSString *)uuidStringRef];
     //CFRelease(uuidStringRef);//通过 __bridge_transfer 交给arc所有，则不需要释放uuidStringRef
     return uuid;
     *
     __bridge:不涉及对象所有关系改变
     __bridge_transfer:给予 ARC 所有权
     __bridge_retained:解除 ARC 所有权
     *
     http://bluevt.org/?p=173
     */
}

+(NSString *)flattenHTML:(NSString *)html
{
    NSScanner *theScanner;
    NSString *text = nil;
    html=[html stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        [theScanner scanUpToString:@">" intoString:&text] ;
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    html=[html stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return html;
}

+(void)callPhone:(NSString *)phone
{
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"])
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                 message:@"您的设备不支持此功能" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction *action) {
                                                                 
                                                             }];
        [alertController addAction:cancelAction];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
            
        }];
        //        [self presentViewController:alertController animated:YES completion:nil];
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@""
        //                                                     message:@"您的设备不支持此功能"
        //                                                    delegate:nil
        //                                           cancelButtonTitle:@"确定"
        //                                           otherButtonTitles:nil];
        //        [alert show];
    }
    else
    {
        if (!phone||[phone isEqualToString:@""])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                                     message:@"号码为空,不能拨打" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定"
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction *action) {
                                                                     
                                                                 }];
            [alertController addAction:cancelAction];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:^{
                
            }];
            
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@""
            //                                                         message:@"号码为空,不能拨打"
            //                                                        delegate:nil
            //                                               cancelButtonTitle:@"确定"
            //                                               otherButtonTitles:nil];
            //            [alert show];
        }
        else
            
        {
            phone=[phone stringByReplacingOccurrencesOfString:@"转" withString:@","];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",phone]]];
        }
    }
}


+(NSString *)weekChinese
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterMediumStyle];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday];
    NSString *week_str=nil;
    switch (week)
    {
        case 1:
            week_str = @"星期日";
            break;
        case 2:
            week_str = @"星期一";
            break;
        case 3:
            week_str = @"星期二";
            break;
        case 4:
            week_str = @"星期三";
            break;
        case 5:
            week_str = @"星期四";
            break;
        case 6:
            week_str = @"星期五";
            break;
        case 7:
            week_str = @"星期六";
            break;
        default:
            break;
    }
    return week_str;
}

+ (NSString *)monthChinese
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    int month = (int) [comps month];
    NSString *monthStr;
    switch (month) {
        case 1:
            monthStr = @"JANUARY";
            break;
        case 2:
            monthStr = @"FEBRUARY";
            break;
        case 3:
            monthStr = @"MARCH";
            break;
        case 4:
            monthStr = @"APRIL";
            break;
        case 5:
            monthStr = @"MAY";
            break;
        case 6:
            monthStr = @"JUNE";
            break;
        case 7:
            monthStr = @"JULY";
            break;
        case 8:
            monthStr = @"AUGUST";
            break;
        case 9:
            monthStr = @"SEPTEMBER";
            break;
        case 10:
            monthStr = @"OCTOBER";
            break;
        case 11:
            monthStr = @"NOVEMBER";
            break;
        case 12:
            monthStr = @"DECEMBER";
            break;
        default:
            break;
    }
    return monthStr;
}

+ (NSString *)dayChinese
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |
    NSCalendarUnitDay |
    NSCalendarUnitWeekday |
    NSCalendarUnitHour |
    NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:date];
    int day = (int) [comps day];
    NSString *dayStr = [NSString stringWithFormat:@"%d",day];
    return dayStr;
}

//时间戳转换成时间格式
+ (NSString *)dateTime:(NSString *)dateStr
{
    long int dataT = [dateStr intValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:dataT];
    NSString *nowtimeStr = [formatter stringFromDate:confromTimesp];
    return nowtimeStr;
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSLocale *enLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [format setLocale:enLocale];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateString = [format stringFromDate:date];
    return dateString;
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+(NSString*)getIdentificationBirthdayDate:(NSString*)carId
{
    NSMutableString * dateStr=[NSMutableString stringWithString:[carId substringWithRange:NSMakeRange(6, 8)]];
    [dateStr insertString:@"-" atIndex:4];
    [dateStr insertString:@"-" atIndex:7];
    return dateStr;
}

+(NSString*)writeDocumnetImage:(UIImage*)image
{
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0];
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",[self GetUUID]];
    NSString *imagePath = [filePath stringByAppendingPathComponent:imageName];
    [UIImageJPEGRepresentation(image,1.0) writeToFile:imagePath atomically:YES];
    return imagePath;
}

+ (void)showAlertWithTitle:(NSString *)title Message:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: title
                                                        message: message
                                                       delegate: nil
                                              cancelButtonTitle: @"确定"
                                              otherButtonTitles: nil, nil];
    [alertView show];
}

+(NSString *)getPathFromProject:(NSString *)fileName
{
    return [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],fileName];
}
@end



@implementation NSString (FontApi)

-(CGSize)lyFont:(UIFont *)font constrainedSize:(CGSize)size
{
    CGSize tempsize;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_1
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    tempsize=[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
#else
    tempsize=[self sizeWithFont:font constrainedToSize:size];
#endif
    return tempsize;
}
@end

@implementation UIView (DadView)

- (CGFloat)leftD {
    return self.x / LYBaseScreen;
}

- (CGFloat)topD{
    return self.y / LYBaseScreen;
}

- (CGFloat)rightD{
    return (self.W+self.x) / LYBaseScreen;
}

- (CGFloat)bottomD {
    return self.RBY / LYBaseScreen;
}


- (CGFloat)centerXD{
    return self.center.x / LYBaseScreen;
}

- (void)setCenterXD:(CGFloat)centerX {
    self.center = CGPointMake(centerX * LYBaseScreen, self.center.y);
}

- (CGFloat)centerYD {
    return self.center.y / LYBaseScreen;
}

- (void)setCenterYD:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY * LYBaseScreen);
}

- (CGFloat)widthD {
    return self.frame.size.width / LYBaseScreen;
}

- (CGFloat)heightD {
    return self.frame.size.height / LYBaseScreen;
}


- (CGPoint)originD{
    return self.frameD.origin;
}

- (void)setOriginD:(CGPoint)origin {
    CGRect frame = self.frameD;
    frame.origin = origin;
    self.frameD = frame;
}

- (CGSize)sizeD
{
    return self.frameD.size;
}

- (void)setSizeD:(CGSize)size {
    CGRect frame = self.frameD;
    frame.size = size;
    self.frameD = frame;
}

- (CGRect)frameD
{
    CGRect frame  = self.frame;
    return CGRectMake(frame.origin.x / LYBaseScreen, frame.origin.y / LYBaseScreen, frame.size.width / LYBaseScreen, frame.size.height / LYBaseScreen);
}
- (void)setFrameD:(CGRect)frameBase
{
    self.frame = CGRectMake(frameBase.origin.x * LYBaseScreen, frameBase.origin.y * LYBaseScreen, frameBase.size.width * LYBaseScreen, frameBase.size.height * LYBaseScreen);
}



-(CGFloat)X
{
    return self.frame.origin.x;
}
-(CGFloat)Y
{
    return self.frame.origin.y;
    
}
-(CGFloat)W
{
    return self.frame.size.width;
}
-(CGFloat)H
{
    return self.frame.size.height;
}
-(CGFloat)RBY
{
    return self.frame.origin.y+self.frame.size.height;
}

@end


float h(float h)
{
    return h*LYBaseScreen;
}



BOOL validateNumber(NSString *number)
{
    number=[number stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *reg=@"^[0-9]*[1-9][0-9]*$";
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    return [numberPredicate evaluateWithObject:number];
}


BOOL isNetLink()
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

int textLength(NSString *text)
{
    float number = 0.0;
    for (int index = 0; index < [text length]; index++)
    {
        NSString *character = [text substringWithRange:NSMakeRange(index, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            number++;
        }
        else
        {
            number = number + 0.5;
        }
    }
    return ceil(number);
}

BOOL isHKMobileNumber(NSString *mobileNum)
{
    if (mobileNum.length == 8 || mobileNum.length == 11)
    {
        return YES;
    }
    return NO;
}

BOOL isMobileNumber(NSString *mobileNum)
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[6-8])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|78)\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|76)\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09]|77)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        if ([mobileNum length]==11)
        {
            BOOL tel1=[[mobileNum substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"181"];
            BOOL tel2=[[mobileNum substringWithRange:NSMakeRange(0, 3)] isEqualToString:@"183"];
            if (tel1||tel2)
            {
                NSString *mob=@"^[0-9]*[1-9][0-9]*$";
                NSPredicate *regextestmobile111 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mob];
                if ([regextestmobile111 evaluateWithObject:mobileNum] == YES) {
                    return YES;
                }
            }
        }
        
        return NO;
    }
}

BOOL validateEmail(NSString *str)
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    if(numberofMatch > 0)
    {
        return YES;
    }
    
    return NO;
    
}
BOOL validateString(id obj)
{
    if (!obj||[obj isEqual:[NSNull null]])
    {
        return NO;
    }
    NSString *objString=[NSString stringWithFormat:@"%@",obj];
    if (stringIsNil(objString))
    {
        return NO;
    }
    return YES;
}


BOOL validatePwd(NSString *str)
{
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:@"^[a-zA-Z0-9]{6,16}$"
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    if(numberofMatch > 0)
        return YES;
    
    
    return NO;
}

//简单判定是否为身份证号
BOOL validateIdentityCard1(NSString *identityCard)
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

BOOL validateIdentityCard(NSString *cardID)
{
    //判断位数
    if ([cardID length] != 15 && [cardID length] != 18) {
        return NO;
    }
    NSString *carid = cardID;
    
    long lSumQT =0;
    
    //加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    
    //校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};
    
    
    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:cardID];
    
    if ([cardID length] == 15) {
        
        [mString insertString:@"19" atIndex:6];
        
        long p = 0;
        
        const char *pid = [mString UTF8String];
        
        for (int i=0; i<=16; i++)
            
        {
            
            p += (pid[i]-48) * R[i];
            
        }
        
        int o = p%11;
        
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        
        [mString insertString:string_content atIndex:[mString length]];
        
        carid = mString;
        
    }
    
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [dic setObject:@"北京" forKey:@"11"];
    
    [dic setObject:@"天津" forKey:@"12"];
    
    [dic setObject:@"河北" forKey:@"13"];
    
    [dic setObject:@"山西" forKey:@"14"];
    
    [dic setObject:@"内蒙古" forKey:@"15"];
    
    [dic setObject:@"辽宁" forKey:@"21"];
    
    [dic setObject:@"吉林" forKey:@"22"];
    
    [dic setObject:@"黑龙江" forKey:@"23"];
    
    [dic setObject:@"上海" forKey:@"31"];
    
    [dic setObject:@"江苏" forKey:@"32"];
    
    [dic setObject:@"浙江" forKey:@"33"];
    
    [dic setObject:@"安徽" forKey:@"34"];
    
    [dic setObject:@"福建" forKey:@"35"];
    
    [dic setObject:@"江西" forKey:@"36"];
    
    [dic setObject:@"山东" forKey:@"37"];
    
    [dic setObject:@"河南" forKey:@"41"];
    
    [dic setObject:@"湖北" forKey:@"42"];
    
    [dic setObject:@"湖南" forKey:@"43"];
    
    [dic setObject:@"广东" forKey:@"44"];
    
    [dic setObject:@"广西" forKey:@"45"];
    
    [dic setObject:@"海南" forKey:@"46"];
    
    [dic setObject:@"重庆" forKey:@"50"];
    
    [dic setObject:@"四川" forKey:@"51"];
    
    [dic setObject:@"贵州" forKey:@"52"];
    
    [dic setObject:@"云南" forKey:@"53"];
    
    [dic setObject:@"西藏" forKey:@"54"];
    
    [dic setObject:@"陕西" forKey:@"61"];
    
    [dic setObject:@"甘肃" forKey:@"62"];
    
    [dic setObject:@"青海" forKey:@"63"];
    
    [dic setObject:@"宁夏" forKey:@"64"];
    
    [dic setObject:@"新疆" forKey:@"65"];
    
    [dic setObject:@"台湾" forKey:@"71"];
    
    [dic setObject:@"香港" forKey:@"81"];
    
    [dic setObject:@"澳门" forKey:@"82"];
    
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:sProvince] == nil) {
        
        return NO;
        
    }
    
    
    //年份
    int strYear = [[carid substringWithRange:NSMakeRange(6,4)] intValue];
    
    //月份
    
    int strMonth = [[carid substringWithRange:NSMakeRange(10,2)] intValue];
    
    //日
    int strDay = [[carid substringWithRange:NSMakeRange(12,2)] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    [dateFormatter setTimeZone:localZone];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    
    if (date == nil) {
        return NO;
    }
    
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    
    //校验数字
    for (int i=0; i<18; i++)
    {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    
    //验证最末的校验码
    
    for (int i=0; i<=16; i++)
    {
        lSumQT += (PaperId[i]-48) * R[i];
    }
    
    if (sChecker[lSumQT%11] != PaperId[17] )
    {
        return NO;
    }
    return YES;
}

BOOL stringIsNil(NSString *string)
{
    if (!string||[string isEqualToString:@""]||[string isEqualToString:@"null"]||[string isEqualToString:@"NULL"]||[string isEqualToString:@"nil"] || [string isEqualToString:@"(null)"])
    {
        return YES;
    }
    return NO;
}
BOOL dictValidateObj(id obj)
{
    if (!obj||[obj isEqual:[NSNull null]])
    {
        return NO;
    }
    if (![obj isKindOfClass:[NSDictionary class]])
    {
        return NO;
    }
    return YES;
}


BOOL aryValidateObj(id obj)
{
    if (!obj||[obj isEqual:[NSNull null]])
    {
        return NO;
    }
    if (![obj isKindOfClass:[NSArray class]])
    {
        return NO;
    }
    return YES;
}


BOOL nullObject(id obj)
{
    if (!obj||[obj isEqual:[NSNull null]])
    {
        return YES;
    }
    return NO;
}


NSString *cachesPath(NSString *fileName)
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"] stringByAppendingPathComponent:fileName];
}
NSString *bundlePath(NSString *fileName)
{
    return [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],fileName];
    
}
BOOL haveCachesFile(NSString * fileName)
{
    NSString *path = cachesPath(fileName);
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
    
}
BOOL createCachesFolder(NSString *folderName)
{
    NSString *documentsDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    return [[NSFileManager defaultManager] createDirectoryAtPath:[NSString stringWithFormat:@"%@/%@",documentsDirectory,folderName] withIntermediateDirectories:YES attributes:nil error:nil];
}

BOOL removeCachesFolder(NSString *folderName)
{
    return [[NSFileManager defaultManager] removeItemAtPath:cachesPath(folderName) error:nil];
    
}


UIFont *lyFont(CGFloat fontValue)
{
    return [UIFont fontWithName:@"Helvetica-Light" size:fontValue];
}
UIFont *lyTitleFont(CGFloat fontValue){
    
    return [UIFont fontWithName:@"Helvetica-Bold" size:fontValue];
}
UIFont *lyFontA(NSString *fontName,CGFloat fontValue)
{
    return [UIFont fontWithName:fontName size:fontValue];
}






UIColor *lyColor(CGFloat colorValue)
{
    return [UIColor colorWithRed:colorValue/255.0 green:colorValue/255.0 blue:colorValue/255.0 alpha:1.0];
}

UIColor *lyColorA(CGFloat colorValue,CGFloat a)
{
    return [UIColor colorWithRed:colorValue/255.0 green:colorValue/255.0 blue:colorValue/255.0 alpha:a];
    
}

UIColor *lyColorRGB(CGFloat r,CGFloat g,CGFloat b)
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}
UIColor *lyColorRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a)
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
    
}


int sizeFromPath(NSString *folderPath)
{
    NSArray *contents;
    NSEnumerator *enumerator;
    NSString *path;
    contents = [[NSFileManager defaultManager] subpathsAtPath:folderPath];
    enumerator = [contents objectEnumerator];
    int fileSizeInt = 0;
    while (path = [enumerator nextObject]) {
        NSDictionary *fattrib = [[NSFileManager defaultManager]attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:path] error:nil];
        fileSizeInt +=[fattrib fileSize];
    }
    return fileSizeInt;
}

// 返回 K M G 格式数据
NSString *sizeStringFormPath(NSString *folderPath)
{
    NSArray *contents;
    NSEnumerator *enumerator;
    NSString *path;
    contents = [[NSFileManager defaultManager] subpathsAtPath:folderPath];
    enumerator = [contents objectEnumerator];
    int fileSizeInt = 0;
    while (path = [enumerator nextObject]) {
        NSDictionary *fattrib = [[NSFileManager defaultManager]attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:path] error:nil];
        fileSizeInt +=[fattrib fileSize];
    }
    
    
    float floatSize =(float)fileSizeInt;
    if (floatSize==0)
    {
        return [NSString stringWithFormat:@"0"];
    }
    if (floatSize<1024)
        return([NSString stringWithFormat:@"%.1f b",floatSize]);
    floatSize = floatSize / 1024.0;
    if (floatSize<1024)
        return([NSString stringWithFormat:@"%.1f KB",floatSize]);
    floatSize = floatSize / 1024.0;
    if (floatSize<1024)
        return([NSString stringWithFormat:@"%.1f MB",floatSize]);
    floatSize = floatSize / 1024.0;
    return([NSString stringWithFormat:@"%.1f GB",floatSize]);
}

NSMutableAttributedString *multipleColor(UIColor *color,NSRange range,NSAttributedString *string)
{
    NSMutableAttributedString *strA = [[NSMutableAttributedString alloc]initWithAttributedString:string];
    [strA addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    return strA;
}
NSMutableAttributedString *multipleFont(UIFont *font,NSRange range,NSAttributedString *string)
{
    NSMutableAttributedString *strA = [[NSMutableAttributedString alloc]initWithAttributedString:string];
    [strA addAttribute:NSFontAttributeName value:font range:range];
    
    return strA;
}

