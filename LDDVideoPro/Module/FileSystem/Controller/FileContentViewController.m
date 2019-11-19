//
//  FileContentViewController.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/19.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileContentViewController.h"

@interface FileContentViewController ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation FileContentViewController

- (WKWebView*)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        [_webView loadFileURL:[NSURL fileURLWithPath:self.filePath] allowingReadAccessToURL:[NSURL fileURLWithPath:self.filePath]];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.backgroundColor = [UIColor clearColor];
        _webView.opaque = NO;
        
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文件详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(shareButtonAction)];
    
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@300);
    }];
}


/// 分享文件
- (void)shareButtonAction{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    //app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    //分享的标题
    NSString *textToShare = app_Name;
    
    NSString *filePath = [DocumentsPath stringByAppendingPathComponent:@"WX20191115-171552@2x.png"];
    //分享的url
    NSURL *urlToShare = [NSURL fileURLWithPath:filePath];
    
    //分享的图片
    UIImage *imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlToShare]];
    
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[textToShare, imageToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    //不出现在活动项目
    activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
