//
//  YSEVCommonManager.m
//  tfbank
//
//  Created by langyue on 2018/7/16.
//  Copyright © 2018年 langyue. All rights reserved.
//

#import "FAPCommonManager.h"

@implementation FAPCommonManager

+(BOOL)resultISNONull:(id)result{

    NSString *resultString =[NSString stringWithFormat:@"%@",result];

    if (result==nil||result==NULL||[result isEqual:[NSNull null]]||result==Nil||[result isKindOfClass:[NSNull class]]||[resultString isEqualToString:@"<null>"] || resultString.length<=0||[resultString isEqualToString:@"(null)"]) {

        return NO;
    }
    
    return YES;
}
+(NSString *)lx_mine_stringsNilhandle:(NSString *)string{

    NSString *str=[NSString stringWithFormat:@"%@",string];
    @try {
        if ((str.length<=0)||str==nil||[str isKindOfClass:[NSNull class]]||[str isEqualToString:@"<null>"]||[str isEqualToString:@"(null)"]) {
            str=@"";
        }
        return str;

    } @catch (NSException *exception) {
        ;

    } @finally {
        ;
    }

}
//去掉字符串中的html标签的方法
+(NSString*)filterHtml:(NSString*)html
{
    NSScanner* scanner = [NSScanner scannerWithString:html];
    NSString* text =nil;
    while([scanner isAtEnd]==NO){
        
        //找到标签的起始位置
        [scanner scanUpToString:@"<"intoString:nil];

        //找到标签的结束位置
        [scanner scanUpToString:@">"intoString:&text];

        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text]withString:@""];

        html=[html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    }

    return html;
}
+(NSString*)newfilterHtml:(NSString*)html{

    html=[html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@"\r"];
    html=[html stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];

    return html;
}
+(NSString*)textfilterHtml:(NSString*)html{

    html=[html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    html=[html stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    return html;
}
+(NSString *)handleHtmlPhotoSize:(NSString *)html withLYWIDTH:(CGFloat )width{

    return [NSString stringWithFormat:@"<head><style>img{max-width:%fpx;width:%fpx !important;margin:10px 0;}</style></head>%@",width,width, html];
}
#pragma mark - 获取当前时间
+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}
+(NSMutableAttributedString *)getAttributStringwithlineSpaceing:(NSInteger)linespace withContentString:(NSString *)contentString{
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:contentString];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //设置行间距
    paragraphStyle.lineSpacing = linespace;
    //设置两端对齐显示
    paragraphStyle.alignment = NSTextAlignmentJustified;
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    
    return attributedStr;
}
+(NSInteger)isJudgeisArrayOrNSDictory:(id)result{

    if([result isKindOfClass:[NSArray class]]){//数组

        return 1;

    }else if([result isKindOfClass:[NSDictionary class]]){//字典

        return 2;
    }
    return 0;//其他
}
+(NSInteger)returnCount:(NSInteger )arrCount withnum:(NSInteger )num{

    int IntCount;
    float floatCount;

    IntCount=(int)arrCount/num;
    floatCount=(float)arrCount/num;
    if (floatCount>IntCount) {
        IntCount=IntCount+1;
    }
    return IntCount;
}
#pragma mark - 登录
+(BOOL)lx_mine_isLoginViewController:(LYTBaseViewController *)viewController{
    
    if ([FAPCommonUserInfo userAccessToken].length<=0) {//未登录
        
//        LYTLoginViewController *loginVC=[[LYTLoginViewController alloc]init];
//        loginVC.hidesBottomBarWhenPushed=YES;
//        [viewController.navigationController pushViewController:loginVC animated:YES];
        
        return NO;
    }
    return YES;
}
#pragma mark - 退出登录
+(void)lx_mine_logoutsAccount{
    
    //退出登录
    [FAPCommonUserInfo deleteInfo];
    [FAPCommonUserInfo sendLoginStatusNotification];
}
#pragma mark - 提示框
+(void)lx_mine_hubPromptboxingwithMessage:(NSString *)message withBlock:(hubclickconfirmBlock)confirmBlock withViewController:(LYTBaseViewController *)viewController withCancelBlock:(hubclickcancelBlock)cancelBlock{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action0 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        confirmBlock();
    }];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        cancelBlock();
    }];
    
    [alertVC addAction:action0];
    [alertVC addAction:action1];
    [viewController presentViewController:alertVC animated:YES completion:nil];
    
}
+(void)lx_mine_hubToastMessage:(NSString *)message{
    
    [SVProgressHUD showInfoWithStatus:message];
    [SVProgressHUD setBackgroundColor:RGBColor(234, 234, 234)];
}
+(void)lx_mine_hubFailToastShow{
    
    [SVProgressHUD showErrorWithStatus:NetworkfailureHubMessage];
    [SVProgressHUD setBackgroundColor:RGBColor(234, 234, 234)];
}
+(void)lx_mine_dimSearchKeywordStockInfowithKey:(NSString *)searchString withreturnSearchResult:(searchFinishreturnResultBlock)searchFinishreturnResultBlock{
    
    NSMutableArray *resultArray=[NSMutableArray array];
    
    if (searchString.length>0) {
        
        //===处理数据
        NSString *codepath = [[NSBundle mainBundle] pathForResource:@"FsevfutureCode" ofType:@"plist"];
        
        NSArray *codeArr=[NSArray arrayWithContentsOfFile:codepath];
        
        NSMutableArray *codeKeys=[NSMutableArray array];
        
        NSMutableArray *allVaulesArray=[NSMutableArray array];
        
        for (NSDictionary *codedic in codeArr) {
            
            [codeKeys addObject:codedic[@"key"]];
            
            for (NSDictionary *d in codedic[@"value"]) {
                
                [allVaulesArray addObject:d];
            }
        
        }

        
        for (int i=0;i<codeKeys.count;i++) {
            
            NSString *keys = codeKeys[i];
            
            if ([keys containsString:searchString]) {
                
                NSDictionary *currDic=codeArr[i];
                resultArray=(NSMutableArray *)[NSArray arrayWithObject:currDic[@"keys"]];
                
                searchFinishreturnResultBlock(resultArray);
                
                break;
                
            }else{
                
                if (i==codeKeys.count-1) {//都不包含
                    
                    for (NSDictionary *compareDic in allVaulesArray) {
                        
                        NSString *codeStr=compareDic[@"code"];
                        NSString *nameStr=compareDic[@"name"];

                        if ([codeStr containsString:searchString]||[nameStr containsString:searchString]) {
                            
                            [resultArray addObject:compareDic];
                        }
                        
                    }
                    
                    searchFinishreturnResultBlock(resultArray);
                    
                }
                
            }
        }
    }
}
+(void)lx_mine_NetworkDelaysDoperation:(networkquestFinishBlock)networkquestFinishBlock{
    
    [SVProgressHUD show];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [SVProgressHUD dismiss];
        networkquestFinishBlock();
        
    });
}
#pragma mark - 举报屏蔽弹框
+(void)lx_mine_hubsreportshieldwithReportBlock:(hubclickReportBlock)confirmBlock withSheildBlock:(hubclickSheildBlock)sheildBlock withCancelBlock:(hubclickcancelBlock)cancelBlock withViewController:(LYTBaseViewController *)viewController{
//
//    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"请选择操作" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//    UIAlertAction * report = [UIAlertAction actionWithTitle:@"举报用户" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//        LYTChatReportViewController *reportVC = [[LYTChatReportViewController alloc] init];
//        reportVC.hidesBottomBarWhenPushed = YES;
//        [viewController.navigationController pushViewController:reportVC animated:YES];
//    }];
//
//    UIAlertAction * shield = [UIAlertAction actionWithTitle:@"拉黑用户" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认拉黑该用户？拉黑后将看不到他的信息" preferredStyle:UIAlertControllerStyleAlert];
//
//        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//            //===确认拉黑===
//            sheildBlock();
//
//        }]];
//        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//        [viewController presentViewController:alertController animated:YES completion:nil];
//
//    }];
//    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//
//    [sheet addAction:report];
//    [sheet addAction:shield];
//    [sheet addAction:cancel];
//
//
//    [viewController presentViewController:sheet animated:YES completion:nil];
//
}
@end
