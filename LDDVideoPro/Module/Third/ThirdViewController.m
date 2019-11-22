//
//  MeViewController.m
//  LiveOfBeiJing
//
//  Created by Bingo on 2018/11/19.
//

#import "ThirdViewController.h"
#import "FAPDownloadViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "HSDownloadManager.h"
#import "FAPDownloadTableViewCell.h"
#import "FileSystemNoDataView.h"
#import "FAPNetworkViewController.h"
#import "PaymentViewController.h"

@interface ThirdViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *dirArray; // 存储沙盒里面的所有文件
@property (nonatomic, copy) NSString *downloadUrl;
@property (nonatomic, strong) FileSystemNoDataView *noDataView;

@property (nonatomic, strong) UIImageView *centerImageView;


/// 插屏广告
@property (nonatomic, strong) GADInterstitial *Interstitial;

//banner广告
@property (nonatomic, strong) GADBannerView *bannerAdView;

@end

@implementation ThirdViewController


- (UIImageView*)centerImageView{
    if (!_centerImageView) {
        _centerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cneterImg"]];
        _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _centerImageView;
}

- (FileSystemNoDataView*)noDataView{
    if (!_noDataView) {
        _noDataView = [[FileSystemNoDataView alloc] initWithFrame:CGRectZero desc:@"点击右上角的加号，将网络上的视频\n下载到手机上，下载完成后请前往首页查看" imageName:@"icon_download"];
    }
    return _noDataView;
}

- (void)configNodataView {
    if (self.dirArray.count == 0) {
        [self.view addSubview:self.centerImageView];
        [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            make.height.equalTo(@300);
        }];
//        [self.view addSubview:self.noDataView];
//        [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.view);
//        }];
    } else {
        [self.centerImageView removeFromSuperview];
//        [self.noDataView removeFromSuperview];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"icon_add" highBackgroudImageName:@"icon_add" target:self action:@selector(addClick)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"在线观看" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    [self setupTableView];
    [self setupView];
    
    
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

- (void)setupView {
    
    self.dirArray = [[NSMutableArray alloc] init];
    [self.dirArray addObjectsFromArray:[ThirdViewController getAllHistoryList]];
    [self configNodataView];
    [self.tableV reloadData];
}

- (void)leftClick {
    if ([[PayHelp sharePayHelp] isApplePay]) {
        FAPNetworkViewController *net = [[FAPNetworkViewController alloc] init];
        net.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:net animated:YES];
    } else {
        PaymentViewController *pay = [[PaymentViewController alloc] init];
        [self presentViewController:pay animated:YES completion:nil];
    }
    
}

- (void)addClick {
    
    if ([[PayHelp sharePayHelp] isApplePay]) {
        [self jumpDownload];
    } else {
        PaymentViewController *pay = [[PaymentViewController alloc] init];
        [self presentViewController:pay animated:YES completion:nil];
    }
    
}

- (void)jumpDownload {
    FAPDownloadViewController *net = [[FAPDownloadViewController alloc] init];
    WEAKSELF
    [net setAddSuccess:^(NSString * _Nonnull url) {
        if (![weakSelf.dirArray containsObject:url]) {
            [weakSelf.dirArray addObject:url];
            [ThirdViewController addUrlToHistoryList:url];
            weakSelf.downloadUrl = url;
            [weakSelf.tableV reloadData];
        }
    }];
    net.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:net animated:YES];
}

- (void)setupTableView {
    self.tableV = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
    self.tableV.backgroundColor = [UIColor clearColor];
    self.tableV.tableFooterView = [UIView new];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableV.rowHeight = UITableViewAutomaticDimension;
    self.tableV.estimatedRowHeight = 100;
    [self.tableV registerNib:[UINib nibWithNibName:@"FAPDownloadTableViewCell" bundle:nil] forCellReuseIdentifier:@"FAPDownloadTableViewCell"];
    [self.view addSubview:_tableV];
}

#pragma mark -- UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dirArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"FAPDownloadTableViewCell";
    FAPDownloadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSString *url = self.dirArray[indexPath.row];
    cell.nameLabel.text = [url lastPathComponent];
    cell.progressLabel.text = [NSString stringWithFormat:@"%.f%%", [[HSDownloadManager sharedInstance] progress:url] * 100];
    cell.progressView.progress = [[HSDownloadManager sharedInstance] progress:url];
    if ([url isEqualToString:self.downloadUrl]) {
        [self download:url progressLabel:cell.progressLabel progressView:cell.progressView button:cell.statuButton];
        self.downloadUrl = nil;
    }
    
    WEAKSELF
    [cell setSuccessBlock:^(UILabel * _Nonnull progressLabel, UIProgressView * _Nonnull progressView, UIButton * _Nonnull statuButton) {
        [weakSelf download:url progressLabel:progressLabel progressView:progressView button:statuButton];
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *url = self.dirArray[indexPath.row];
        [ThirdViewController delUrlFromHistoryList:url];
        [self.dirArray removeObject:url];
        [[HSDownloadManager sharedInstance] deleteFile:url];
        [self configNodataView];
        [self.tableV reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
                    [ThirdViewController delUrlFromHistoryList:url];
                    [self.dirArray removeObject:url];
                    [self configNodataView];
                    [self.tableV reloadData];
                    [button setImage:[UIImage imageNamed:@"icon_play"] forState:UIControlStateNormal];
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
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [button setTitle:[self getTitleWithDownloadState:state] forState:UIControlStateNormal];
//        });
    }];
}

+ (void)addUrlToHistoryList:(NSString *)url
{
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[ThirdViewController getAllHistoryList]];
    
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
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[ThirdViewController getAllHistoryList]];
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
