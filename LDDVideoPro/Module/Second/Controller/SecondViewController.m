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

/// 插屏广告
@property (nonatomic, strong) GADInterstitial *Interstitial;

//banner广告
@property (nonatomic, strong) GADBannerView *bannerAdView;


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
    bgView.backgroundColor = [UIColor clearColor];
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
    message.numberOfLines = 3;
    message.textAlignment = NSTextAlignmentCenter;
    message.text = @"确保您的iPhone和PC在同一局域网，文件上传过程中请勿退出，在您的在PC的浏览器中访问以下地址：";
    message.textColor = [UIColor whiteColor];
    message.font = [UIFont systemFontOfSize:15.0];
    [bgView addSubview:message];
    [message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView).offset(16);
        make.right.equalTo(bgView).offset(-16);
        make.height.mas_equalTo(80);
        make.bottom.equalTo(bgView.mas_bottom).offset(-60);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"";
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
        make.top.equalTo(message.mas_bottom).offset(20);
    }];
    
    if (![[PayHelp sharePayHelp] isApplePay]) {
        [self.view addSubview:self.payButton];
        [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(20);
            make.right.equalTo(self.view).offset(-20);
            make.height.mas_equalTo(44);
            make.bottom.equalTo(self.view).offset(-70);
        }];
        self.urlLabel.text = @"********************";
        
    } else {
        [self initServer];
    }
    
    
    if (![[PayHelp sharePayHelp] isApplePay]) {
           [self addAdViews];
       }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(paymentSuccess) name:@"paySuccess" object:nil];

}

- (void)paymentSuccess{
    [_bannerAdView removeFromSuperview];
    self.Interstitial = nil;
}

- (void)addAdViews{
    //加载广告
    _bannerAdView = [[GADBannerView alloc] init];
    _bannerAdView.adUnitID = BannerADID;
    _bannerAdView.rootViewController = self;
    
    GADRequest *request = [GADRequest request];
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[kGADSimulatorID];
    
    [_bannerAdView loadRequest:request];
    [self.view addSubview:_bannerAdView];
    
    [_bannerAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    
    //插屏广告
    self.Interstitial = [[GADInterstitial alloc] initWithAdUnitID:InteredADID];
    GADRequest *request1 = [GADRequest request];
    GADMobileAds.sharedInstance.requestConfiguration.testDeviceIdentifiers = @[kGADSimulatorID];
    [self.Interstitial loadRequest:request1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if ([self.Interstitial isReady]) {
        [self.Interstitial presentFromRootViewController:self];
    }
}

- (void)dealloc{
       [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        [_payButton setBackgroundImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
        [_payButton setTitle:@"更多懂你的精彩" forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _payButton;
}

- (void)payClick {
    PaymentViewController *pay = [[PaymentViewController alloc] init];
    [self presentViewController:pay animated:YES completion:nil];
}

@end
