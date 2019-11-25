//
//  NSString+GLDate.m
//  GLKLineKit
//
//  Created by walker on 2018/5/26.
//  Copyright © 2018年 walker. All rights reserved.
//

#import "NSString+GLDate.h"

@implementation NSString (GLDate)

/**
 根据传入的格式将时间戳转换为响应的字符串
 
 @param timeStamp 时间戳(秒)
 @param formatterString 格式字符串
 @return 转换后的日期
 */
+ (NSString * _Nullable)gl_convertTimeStamp:(NSTimeInterval)timeStamp toFormatter:(NSString *)formatterString {
    
    NSString *result = @"";
    // 生成NSDate对象
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    // 生成日期格式对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 设置格式
    if (formatterString && formatterString.length >= 1) {
        [dateFormatter setDateFormat:formatterString];
    }
    // 根据格式导出日期
    result = [dateFormatter stringFromDate:date];
    return result;
}


/**
 获得今天开始的时间戳
 
 @return 今天0点的时间戳
 */
+ (NSDate *)gl_getTodayStartStamp {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *todayCom = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    
    NSDate *todayDate = [calendar dateFromComponents:todayCom];
    
    return todayDate;
}

+ (int)compareOneDay:(NSString *)oneDay withAnotherDay:(NSString *)anotherDay format:(NSString *)format {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *dateA = [dateFormat dateFromString:oneDay];
    NSDate *dateB = [dateFormat dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
            //NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
            //NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
        //NSLog(@"两者时间是同一个时间");
    return 0;
}

@end
