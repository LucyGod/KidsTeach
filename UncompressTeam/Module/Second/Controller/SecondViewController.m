//
//  SecondViewController.m
//  LDDVideoPro
//
//  Created by mac on 2019/11/25.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "SecondViewController.h"
#import "FAPiTunesDownloadViewController.h"
#import "FAPWiFiTransmitViewController.h"
#import "FAPDLloadViewController.h"
#import "iCloudManager.h"
#import "ImageTitleTableViewCell.h"
#import "SMBViewController.h"
@interface SecondViewController ()<UITableViewDelegate, UITableViewDataSource,UIDocumentPickerDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,copy) NSArray *nameArray;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 60;
        [self.view addSubview:tableView];
        tableView;
    });
    
    [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.top.bottom.equalTo(self.view);
    }];
    [_myTableView registerNib:[UINib nibWithNibName:@"ImageTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"ImageTitleTableViewCell"];
     [_myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HEADER"];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nameArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageTitleTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"ImageTitleTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.nameArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            FAPWiFiTransmitViewController *wifi = [[FAPWiFiTransmitViewController alloc] init];
            wifi.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:wifi animated:YES];
        }
            break;
        case 1:
        {
            FAPiTunesDownloadViewController *itunes = [[FAPiTunesDownloadViewController alloc] init];
            itunes.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:itunes animated:YES];
        }
            break;
        case 2:
        {
            FAPDLloadViewController *download = [[FAPDLloadViewController alloc] init];
            download.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:download animated:YES];
        }
            break;
        case 3:
        {
           UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.data"]
                                                                                                                          inMode:UIDocumentPickerModeImport];
                  documentPicker.delegate = self;

            documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:documentPicker animated:YES completion:nil];
        }
            break;
        case 4:
        {
            SMBViewController *smb = [[SMBViewController alloc] init];
            smb.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:smb animated:YES];
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"] options:@{} completionHandler:nil];
//            } else {
//                [SVProgressHUD showErrorWithStatus:@"您还没有安装微信"];
//            }
        }
            break;
        case 5:
        {
//            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
//                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mqq://"] options:@{} completionHandler:nil];
//            } else {
//                [SVProgressHUD showErrorWithStatus:@"您还没有安装QQ"];
//            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - iCloud files
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    if (controller.documentPickerMode == UIDocumentPickerModeImport) {
        //  NSString *alertMessage = [NSString stringWithFormat:@"Successfully imported %@", [url lastPathComponent]];
        //do stuff
        NSArray *array = [[url absoluteString] componentsSeparatedByString:@"/"];
        NSString *fileName = [array lastObject];
        fileName = [fileName stringByRemovingPercentEncoding];
//        if ([iCloudManager iCloudEnable]) {
            [iCloudManager downloadWithDocumentURL:url callBack:^(id obj) {
                NSData *data = obj;
                
                //写入沙盒Documents
                 NSString *path = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",fileName]];
                [data writeToFile:path atomically:YES];
                [SVProgressHUD showSuccessWithStatus:@"下载成功，请前往首页查看"];
            }];
//        }
    }
    
}

- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSArray arrayWithObjects:@"WiFi传输",@"iTunes传输",@"浏览器下载",@"文件/iCloud Driver",@"SMB",@"设置", nil];
    }
    return _nameArray;
}

@end
