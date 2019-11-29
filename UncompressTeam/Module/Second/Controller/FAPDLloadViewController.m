//
//  FAPDLloadViewController.m
//  UncompressTeam
//
//  Created by MAC on 26/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPDLloadViewController.h"
#import "FAPDownLoadHeader.h"
#import "FAPDownloadTableViewCell.h"
#import "HSDownloadManager.h"
@interface FAPDLloadViewController ()<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UITableView *downloadTableView;
@property (nonatomic, strong)NSMutableArray *downloadArray;
@property (nonatomic, copy) NSString *currentUrl;

@end

@implementation FAPDLloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"浏览器";
    UIView *bgView  = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 3;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.view.mas_top).offset(30);
    }];
    
    UIImageView *igView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_search"]];
    [bgView addSubview:igView];
    [igView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView.mas_centerY);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(30*0.8, 33*0.8));
    }];
    
    [bgView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(igView.mas_right).offset(5);
        make.right.equalTo(bgView.mas_right).offset(-5);
        make.top.equalTo(bgView.mas_top).offset(5);
        make.bottom.equalTo(bgView.mas_bottom).offset(-5);
    }];
    
    [self.view addSubview:self.downloadTableView];
    [self.downloadTableView registerNib:[UINib nibWithNibName:@"FAPDownloadTableViewCell" bundle:nil] forCellReuseIdentifier:@"FAPDownloadTableViewCell"];
    [self.downloadTableView registerClass:[FAPDownLoadHeader class] forHeaderFooterViewReuseIdentifier:@"FAPDownLoadHeader"];
    [self.downloadTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.top.equalTo(bgView.mas_bottom).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
}

#pragma mark 开启任务下载资源
- (void)download:(NSString *)url progressLabel:(UILabel *)progressLabel progressView:(UIProgressView *)progressView button:(UIButton *)button
{
    [[HSDownloadManager sharedInstance] download:url progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            progressLabel.text = [NSString stringWithFormat:@"%.f%%", progress * 100];
            progressView.progress = progress;
        });
    } state:^(DownloadState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            switch (state) {
                case DownloadStateStart:
                {
                    [button setImage:[UIImage imageNamed:@"icon_pause"] forState:UIControlStateNormal];
                }
                    break;
                case DownloadStateSuspended:
                {
                    [button setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
                }
                    break;
                case DownloadStateCompleted:
                {
                    [FAPDLloadViewController delUrlFromHistoryList:url];
                    [self.downloadArray removeObject:url];
//                    [self configNodataView];
                    [self.downloadTableView reloadData];
                    [button setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
                    [SVProgressHUD showSuccessWithStatus:@"下载成功，请前往首页查看"];
                }
                    break;
                case DownloadStateFailed:
                {
                    [SVProgressHUD showErrorWithStatus:@"下载失败"];
                    [button setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
                }
                    break;
                    
                default:
                    break;
            }
        });
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField; {
    
    if ([[PayHelp sharePayHelp] isApplePay]) {
        if (textField.text.length > 0) {
            if (![self.downloadArray containsObject:textField.text]) {
                [self.downloadArray addObject:textField.text];
            }
            [FAPDLloadViewController addUrlToHistoryList:textField.text];
            self.currentUrl = textField.text;
            [self.downloadTableView reloadData];
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"网址不能为空"];
        }
    } else {
        PayViewController *pay = [[PayViewController alloc] init];
        pay.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:pay animated:YES completion:^{
            
        }];
    }
    
    
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.downloadArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.textField.text = self.downloadArray[indexPath.row];
//    PlayerViewController *palyVC = [[PlayerViewController alloc] init];
//    palyVC.hidesBottomBarWhenPushed = YES;
//    [palyVC playWithVideoUrl:self.downloadArray[indexPath.row]];
//    [self.navigationController presentViewController:palyVC animated:YES completion:^{
//        
//    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"FAPDownloadTableViewCell";
    FAPDownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSString *url = self.downloadArray[indexPath.row];
    cell.nameLabel.text = [url lastPathComponent];
    cell.progressLabel.text = [NSString stringWithFormat:@"%.f%%", [[HSDownloadManager sharedInstance] progress:url] * 100];
    cell.progressView.progress = [[HSDownloadManager sharedInstance] progress:url];
    if ([url isEqualToString:self.currentUrl]) {
        [self download:url progressLabel:cell.progressLabel progressView:cell.progressView button:cell.statuButton];
        self.currentUrl = nil;
    }
    
    WEAKSELF
    [cell setSuccessBlock:^(UILabel * _Nonnull progressLabel, UIProgressView * _Nonnull progressView, UIButton * _Nonnull statuButton) {
        [weakSelf download:url progressLabel:progressLabel progressView:progressView button:statuButton];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FAPDownLoadHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FAPDownLoadHeader"];
    return header;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *url = self.downloadArray[indexPath.row];
        [FAPDLloadViewController delUrlFromHistoryList:url];
        [self.downloadArray removeObject:url];
        [[HSDownloadManager sharedInstance] deleteFile:url];
//        [self configNodataView];
        [self.downloadTableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入网址";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeySearch;
    }
    return _textField;
}

- (UITableView *)downloadTableView {
    if (!_downloadTableView) {
        _downloadTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _downloadTableView.backgroundColor = [UIColor clearColor];
        _downloadTableView.dataSource = self;
        _downloadTableView.delegate = self;
        _downloadTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _downloadTableView.rowHeight = 35;
        _downloadTableView.rowHeight = UITableViewAutomaticDimension;
        _downloadTableView.estimatedRowHeight = 100;
    }
    return _downloadTableView;
}

- (NSMutableArray *)downloadArray {
    if (!_downloadArray) {
        _downloadArray = [NSMutableArray array];
        [_downloadArray addObjectsFromArray:[FAPDLloadViewController getAllHistoryList]];
    }
    return _downloadArray;
}

+ (void)addUrlToHistoryList:(NSString *)url
{
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[FAPDLloadViewController getAllHistoryList]];
    
    if ([muarr containsObject:url]) {
        
    } else {
        [muarr addObject:url];
        NSString *key = @"Download_Url_History";
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)delUrlFromHistoryList:(NSString *)url {
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[FAPDLloadViewController getAllHistoryList]];
    if ([muarr containsObject:url]) {
        [muarr removeObject:url];
        NSString *key = @"Download_Url_History";
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        
    }
}

+ (NSArray *)getAllHistoryList
{
    
    NSString *key = @"Download_Url_History";
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    
    if (array) {
        return array;
    }
    
    return nil;
}

@end
