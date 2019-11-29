//
//  FAPWiFiTransmitViewController.m
//  UncompressTeam
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPWiFiTransmitViewController.h"
#import "WiFiTransmitTableViewCell.h"
#import "TitleSwitchTableViewCell.h"
#import <HTTPServer.h>
#import "HmHTTPConnection.h"
#import "HmTool.h"
@interface FAPWiFiTransmitViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    HTTPServer *httpServer;
}
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy) NSString *urlString;

@end

@implementation FAPWiFiTransmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"WiFi传输";
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = ASOColorBackGround;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 60;
        [self.view addSubview:tableView];
        tableView;
    });
    [_myTableView registerNib:[UINib nibWithNibName:@"WiFiTransmitTableViewCell" bundle:nil] forCellReuseIdentifier:@"WiFiTransmitTableViewCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"TitleSwitchTableViewCell" bundle:nil] forCellReuseIdentifier:@"TitleSwitchTableViewCell"];
    [_myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HEADER"];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return 100;
    } else {
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        TitleSwitchTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"TitleSwitchTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"打开WiFi传输";
        cell.mySwith.hidden = YES;
        return cell;
    } else if (indexPath.row == 1) {
        TitleSwitchTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"TitleSwitchTableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text = @"开启";
        [cell.mySwith addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
        cell.mySwith.hidden = NO;
        cell.mySwith.on = self.isOpen;
        return cell;
    } else if (indexPath.row == 2) {
        WiFiTransmitTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"WiFiTransmitTableViewCell" forIndexPath:indexPath];
        if (self.isOpen) {
            cell.titleLabel.text = self.urlString;
            cell.contentLabel.text = @"请确保手机和电脑在同一局域网内，然后在电脑上打开浏览器，输入上面的地址，开始输入文件。";
        } else {
            cell.titleLabel.text = @"传输已关闭";
            cell.contentLabel.text = @"";
        }
        cell.bottomLine.hidden = YES;
        return cell;
    }
    return nil;
}

- (void)valueChanged:(UISwitch *)mySwitch {
    if ([[PayHelp sharePayHelp] isApplePay]) {
        if (mySwitch.on) {
            self.isOpen = YES;
            httpServer = [[HTTPServer alloc] init];
            [httpServer setType:@"_http._tcp."];
            // webPath是server搜寻HTML等文件的路径
            NSString *webPath = [[NSBundle mainBundle] resourcePath];
            [httpServer setDocumentRoot:webPath];
            [httpServer setConnectionClass:[HmHTTPConnection class]];
            NSError *error;
            if ([httpServer start:&error]) {
                self.urlString = [NSString stringWithFormat:@"http://%@:%hu",[HmTool getIPAddress:YES],[httpServer listeningPort]];
                NSLog(@"IP: %@:%hu", [HmTool getIPAddress:YES], [httpServer listeningPort]);
            }else {
                self.urlString = @"http://error";
            }
        } else {
            self.isOpen = NO;
            
        }
        [_myTableView reloadData];
    } else {
        self.isOpen = NO;
        [_myTableView reloadData];
        PayViewController *pay = [[PayViewController alloc] init];
        pay.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:pay animated:YES completion:^{
            
        }];
    }
    
}
 
@end
