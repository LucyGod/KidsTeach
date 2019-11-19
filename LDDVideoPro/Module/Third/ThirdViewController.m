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
@interface ThirdViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) NSMutableArray *dirArray; // 存储沙盒里面的所有文件
@end

@implementation ThirdViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"icon_add" highBackgroudImageName:@"icon_add" target:self action:@selector(addClick)];
    [self setupTableView];
    [self setupView];
}

- (void)setupView {
    
    self.dirArray = [[NSMutableArray alloc] init];
    [self.dirArray addObjectsFromArray:[ThirdViewController getAllHistoryList]];
    [self.tableV reloadData];
}

- (void)addClick {
    FAPDownloadViewController *net = [[FAPDownloadViewController alloc] init];
    WEAKSELF
    [net setAddSuccess:^(NSString * _Nonnull url) {
        [weakSelf.dirArray addObject:url];
        [ThirdViewController addUrlToHistoryList:url];
        [weakSelf.tableV reloadData];
    }];
    net.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:net animated:YES];
    return;
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
    cell.nameLabel.text = url;
    if (![[HSDownloadManager sharedInstance] isPause:url]) {
        [self download:url progressLabel:cell.progressLabel progressView:cell.progressView button:cell.statuButton];
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
