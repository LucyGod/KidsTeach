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
#import "UIBarButtonItem+Extension.h"
#import "FAPNetworkViewController.h"
#import "FAPiTunesShareViewController.h"
#import "PaymentViewController.h"

@interface SecondViewController (){
    HTTPServer *httpServer;
}

@property (nonatomic, strong) UILabel *urlLabel;
@property (nonatomic, strong) UIButton *payButton;

@end

@implementation SecondViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([[PayHelp sharePayHelp] isApplePay] && [self.urlLabel.text isEqualToString:@"********************"]) {
        [self initServer];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"bt_navigation_refresh" highBackgroudImageName:@"bt_navigation_refresh" target:self action:@selector(refreshClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"iTunes传输" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor colorWithHexString:@"5fa6f8"];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(320);
    }];
    
    UIImageView *sendImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_send_bg"]];
    [bgView addSubview:sendImage];
    [sendImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bgView.mas_centerX);
        make.width.mas_equalTo(SCREEN_Width - 60);
        make.height.mas_equalTo(sendImage.mas_width).multipliedBy(0.3);
        make.top.equalTo(bgView.mas_top).offset(50);
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
    
    if (![[PayHelp sharePayHelp] isApplePay]) {
        [self.view addSubview:self.payButton];
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 40));
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(self.urlLabel.mas_bottom).offset(40);
        }];
        self.urlLabel.text = @"********************";
        
    } else {
        [self initServer];
    }
    
    

}

- (void)leftClick {
    FAPiTunesShareViewController *net = [[FAPiTunesShareViewController alloc] init];
    net.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:net animated:YES];
}

- (void)refreshClick {
    if (![[PayHelp sharePayHelp] isApplePay]) {
        return;
    }
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
        self.urlLabel.text = @"http://error";
    }
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
        self.urlLabel.text = @"http://error";
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

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.layer.cornerRadius = 3;
        _payButton.layer.masksToBounds = YES;
        [_payButton setTitle:@"开启服务" forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _payButton.backgroundColor = [UIColor colorWithHexString:@"5fa6f8"];
    }
    return _payButton;
}

- (void)payClick {
    PaymentViewController *pay = [[PaymentViewController alloc] init];
    [self presentViewController:pay animated:YES completion:nil];
}

@end
