//
//  FileSysDetailViewController.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileSysDetailViewController.h"
#import "FileSystemDetailView.h"
#import "FileManagerTool.h"
#import "FileSystemMoveSelecteView.h"
#import "MoveFileViewController.h"
#import "PlayerViewController.h"
#import "PaymentViewController.h"

@interface FileSysDetailViewController ()<FileSystemMoveViewDelegate,DirectoryDetailDelegate,MoveFileSuccessDelegate>

@property (nonatomic, strong) FileSystemDetailView *detailView;

@property (nonatomic, strong) FileSystemMoveSelecteView *moveSelecteView;

/// 插屏广告
@property (nonatomic, strong) GADInterstitial *Interstitial;

//banner广告
@property (nonatomic, strong) GADBannerView *bannerAdView;


@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation FileSysDetailViewController

- (FileSystemMoveSelecteView*)moveSelecteView{
    if (!_moveSelecteView) {
        _moveSelecteView = [[FileSystemMoveSelecteView alloc] initWithFrame:CGRectZero];
        _moveSelecteView.delegate = self;
    }
    return _moveSelecteView;
}

- (FileSystemDetailView*)detailView{
    if (!_detailView) {
        _detailView = [[FileSystemDetailView alloc] initWithFrame:CGRectZero];
        _detailView.delegate = self;
        _detailView.currentDir = self.title;
    }
    return _detailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"move_right"] style:UIBarButtonItemStyleDone target:self action:@selector(moveItemAction)];


    [self.view addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self getDirectoryDetailInfo];
    
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
    [self.detailView addSubview:_bannerAdView];
    
    [_bannerAdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.detailView);
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


#pragma mark - 点击文件夹内的内容回调
- (void)didClickedFileWithFilePath:(NSString *)filePath{
    NSString *finalPath = [[DocumentsPath stringByAppendingPathComponent:self.title] stringByAppendingPathComponent:filePath];
    
    NSLog(@"所点击的文件路径L：%@",finalPath);
    
    if ([[PayHelp sharePayHelp] isApplePay]) {
        //付费
        PlayerViewController *player = [[PlayerViewController alloc] init];
        [player playWithVideoFilePath:finalPath];
        player.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:player animated:YES completion:nil];
    }else{
        //免费
        NSString *fileExtension = [filePath pathExtension];
           if ([fileExtension isEqualToString:@"mp4"] || [fileExtension isEqualToString:@"mov"] || [fileExtension isEqualToString:@"3gp"]) {
               PlayerViewController *player = [[PlayerViewController alloc] init];
               [player playWithVideoFilePath:finalPath];
               player.modalPresentationStyle = UIModalPresentationFullScreen;
               [self presentViewController:player animated:YES completion:nil];
           }else{
               PaymentViewController *payVC = [[PaymentViewController alloc] init];
               
               [self presentViewController:payVC animated:YES completion:nil];
           }
    }
}

- (void)updateSelectedData:(NSMutableArray *)selectedArray{
    NSLog(@"所选数据条数：%ld\n所选数据：%@",selectedArray.count,selectedArray);
    [_moveSelecteView updateSelectedCount:selectedArray];
    
    [self.dataArray removeAllObjects];

    for (NSString *fileNmae in selectedArray) {
        NSString *originPath = [[DocumentsPath stringByAppendingPathComponent:self.title] stringByAppendingPathComponent:fileNmae];
        
        [self.dataArray addObject:originPath];
    }
    
}

/// 移动文件
- (void)moveItemAction{
    BOOL isEdit = !self.detailView.tableView.isEditing;
    [self.detailView.tableView setEditing:isEdit animated:YES];
    
    if (isEdit) {
        //显示moveSelecteView
        [self.view addSubview:self.moveSelecteView];
        [self.moveSelecteView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.equalTo(@(NavMustAdd + 50));
        }];
    }else{
        [self.moveSelecteView removeFromSuperview];
        self.moveSelecteView = nil;
    }
}

- (void)moveFilesCompletionHandler{
    MoveFileViewController *moveFileVC = [[MoveFileViewController alloc] init];
    moveFileVC.originPaths = self.dataArray;
    moveFileVC.originDirectory = self.title;
    moveFileVC.delegate = self;
    LYTBaseNavigationController *nav = [[LYTBaseNavigationController alloc] initWithRootViewController:moveFileVC];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;

    [self presentViewController:nav animated:YES completion:nil];
}

- (void)getDirectoryDetailInfo{
    NSString * dirPath = [DocumentsPath stringByAppendingPathComponent:self.title];
    if ([[FileManagerTool sharedManagerTool] directoryIsExist:self.title]) {
              
        NSMutableArray * pathArray = [[FileManagerTool sharedManagerTool] contentsOfDirectory:dirPath];
        
        [self.detailView updateDetailView:pathArray];

    }else{
        [SVProgressHUD showErrorWithStatus:@"文件目录不存在！"];
    }
}

#pragma mark - 移动文件成功的回调
- (void)didMoveFileSuccessHandler:(NSMutableArray *)originPaths{
    NSLog(@"移动文件成功，文件原始路径:%@",originPaths);
    
    [_moveSelecteView updateSelectedCount:[NSMutableArray array]];

    [self moveItemAction];
    //刷新数据
    [self getDirectoryDetailInfo];
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
