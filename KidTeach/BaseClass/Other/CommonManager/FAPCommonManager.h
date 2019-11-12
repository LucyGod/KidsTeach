//
//  YSEVCommonManager.h
//  tfbank
//
//  Created by langyue on 2018/7/16.
//  Copyright © 2018年 langyue. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "LYTBaseNavigationController.h"
#import "LYTBaseViewController.h"

typedef void(^hubclickconfirmBlock)(void);
typedef void(^hubclickcancelBlock)(void);
typedef void(^searchFinishreturnResultBlock)(NSArray *array);
typedef void(^networkquestFinishBlock)(void);

typedef void(^hubclickReportBlock)(void);
typedef void(^hubclickSheildBlock)(void);

@interface FAPCommonManager : NSObject

+(NSString *)lx_mine_stringsNilhandle:(NSString *)string;
+(BOOL)resultISNONull:(id)result;
+(NSString*)filterHtml:(NSString*)html;
+(NSString*)newfilterHtml:(NSString*)html;
+(NSString*)textfilterHtml:(NSString*)html;
//处理html中的图片问题
+(NSString *)handleHtmlPhotoSize:(NSString *)html withLYWIDTH:(CGFloat )width;
+(NSString*)getCurrentTimes;//获取当前时间
+(NSMutableAttributedString *)getAttributStringwithlineSpaceing:(NSInteger)linespace withContentString:(NSString *)contentString;

+(NSInteger)isJudgeisArrayOrNSDictory:(id)result;
+(NSInteger)returnCount:(NSInteger)arrCount withnum:(NSInteger )num;

//提示确认框
+(void)lx_mine_hubPromptboxingwithMessage:(NSString *)message withBlock:(hubclickconfirmBlock)confirmBlock withViewController:(LYTBaseViewController *)viewController withCancelBlock:(hubclickcancelBlock)cancelBlock;

//屏蔽、举报提示框
+(void)lx_mine_hubsreportshieldwithReportBlock:(hubclickReportBlock)confirmBlock withSheildBlock:(hubclickSheildBlock)sheildBlock withCancelBlock:(hubclickcancelBlock)cancelBlock withViewController:(LYTBaseViewController *)viewController;

+(void)lx_mine_hubToastMessage:(NSString *)message;
+(void)lx_mine_hubFailToastShow;

//===登录，退出登录===
+(BOOL)lx_mine_isLoginViewController:(LYTBaseViewController *)viewController;
+(void)lx_mine_logoutsAccount;
//模糊搜索匹配
+(void)lx_mine_dimSearchKeywordStockInfowithKey:(NSString *)searchString withreturnSearchResult:(searchFinishreturnResultBlock)searchFinishreturnResultBlock;

+(void)lx_mine_NetworkDelaysDoperation:(networkquestFinishBlock)networkquestFinishBlock;


@end
