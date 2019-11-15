//
//  FindViewController.m
//  LiveOfBeiJing
//
//  Created by Bingo on 2018/11/30.
//

#import "SecondViewController.h"
#import "HmHTTPConnection.h"
#import "HmTool.h"
#import <HTTPServer.h>

@interface SecondViewController (){
    HTTPServer *httpServer;
}

@property (nonatomic, strong) UILabel *urlLabel;

@end

@implementation SecondViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithHexString:@"5fa6f8"];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(320);
    }];
    
    UILabel *message = [[UILabel alloc] init];
    message.numberOfLines = 2;
    message.textAlignment = NSTextAlignmentCenter;
    message.text = @"确保您的iPhone和PC在同一局域网，文件\n上传过程中请勿退出";
    message.textColor = [UIColor whiteColor];
    [bgView addSubview:message];
    [message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(60);
        make.bottom.equalTo(bgView.mas_bottom).offset(-60);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"在PC的浏览器中访问以下地址";
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(20);
        make.top.equalTo(bgView.mas_bottom).offset(40);
    }];
    
    [self.view addSubview:self.urlLabel];
    [self.urlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(44);
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
    }];
    
    [self initServer];

}

// 初始化本地服务器
- (void)initServer {
    httpServer = [[HTTPServer alloc] init];
    [httpServer setType:@"_http._tcp."];
    // webPath是server搜寻HTML等文件的路径
    NSString *webPath = [[NSBundle mainBundle] resourcePath];
    [httpServer setDocumentRoot:webPath];
    [httpServer setConnectionClass:[HmHTTPConnection class]];
    NSError *error;
    if ([httpServer start:&error]) {
        self.urlLabel.text = [NSString stringWithFormat:@"http://%@:%hu",[HmTool getIPAddress:YES],[httpServer listeningPort]];
        NSLog(@"IP: %@:%hu", [HmTool getIPAddress:YES], [httpServer listeningPort]);
    }else {
        NSLog(@"%@", error);
    }
}

- (UILabel *)urlLabel {
    if (!_urlLabel) {
        _urlLabel = [[UILabel alloc] init];
        _urlLabel.backgroundColor = [UIColor colorWithHexString:@"5fa6f8"];
        _urlLabel.layer.cornerRadius = 22;
        _urlLabel.layer.masksToBounds = YES;
        _urlLabel.textAlignment = NSTextAlignmentCenter;
        _urlLabel.text = @"";
        _urlLabel.textColor = [UIColor whiteColor];
    }
    return _urlLabel;
}

@end
