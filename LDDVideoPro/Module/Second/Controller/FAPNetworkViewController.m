//
//  FAPNetworkViewController.m
//  LDDVideoPro
//
//  Created by MAC on 18/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPNetworkViewController.h"
#import "FAPNetworkHistoryCell.h"
#import "FAPNetworkHeader.h"
#import "PlayerViewController.h"
#import "PaymentViewController.h"
#import "ThirdViewController.h"
#import "UIBarButtonItem+Extension.h"
@interface FAPNetworkViewController ()<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UITableView *historyTableView;
@property (nonatomic, strong)NSMutableArray *historyArray;

@end

@implementation FAPNetworkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"在线";
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [dateFormat stringFromDate:[NSDate date]];
//
//    NSString *dateTime = [NSDate datestrFromDate:[NSDate date] withDateFormat:@"yyyy-MM-dd"];
    if ([NSString compareOneDay:dateTime withAnotherDay:@"2019-11-30" format:@"yyyy-MM-dd"] == 1) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"下载" style:UIBarButtonItemStylePlain target:self action:@selector(addClick)];
    }
    
    
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.numberOfLines = 2;
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.text = @"请输入网络播放地址";
//    titleLabel.textColor = [UIColor whiteColor];
//    [self.view addSubview:titleLabel];
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(20);
//        make.top.equalTo(self.view.mas_top).offset(40);
//    }];
    
    UIView *bgView  = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 3;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(40);
        make.right.equalTo(self.view.mas_right).offset(-40);
        make.height.mas_equalTo(44);
        make.top.equalTo(self.view.mas_top).offset(40);
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
    
    [self.view addSubview:self.historyTableView];
    [self.historyTableView registerNib:[UINib nibWithNibName:@"FAPNetworkHistoryCell" bundle:nil] forCellReuseIdentifier:@"FAPNetworkHistoryCell"];
    [self.historyTableView registerClass:[FAPNetworkHeader class] forHeaderFooterViewReuseIdentifier:@"FAPNetworkHeader"];
    [self.historyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView);
        make.top.equalTo(bgView.mas_bottom).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
    
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
    ThirdViewController *three = [[ThirdViewController alloc] init];
    three.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:three animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historyArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.textField.text = self.historyArray[indexPath.row];
    PlayerViewController *palyVC = [[PlayerViewController alloc] init];
    palyVC.hidesBottomBarWhenPushed = YES;
    [palyVC playWithVideoUrl:self.historyArray[indexPath.row]];
    [self.navigationController presentViewController:palyVC animated:YES completion:^{
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FAPNetworkHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FAPNetworkHistoryCell"];
    cell.titleLabel.text = self.historyArray[indexPath.row];
    WEAKSELF
    [cell setDelSuccess:^{
        NSString *url = weakSelf.historyArray[indexPath.row];
        [weakSelf.historyArray removeObject:url];
        [FAPNetworkViewController delUrlFromHistoryList:url];
        [weakSelf.historyTableView reloadData];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FAPNetworkHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"FAPNetworkHeader"];
    return header;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField; {
    if (textField.text.length > 0) {
        if (![self.historyArray containsObject:textField.text]) {
            [self.historyArray addObject:textField.text];
        }
        [FAPNetworkViewController addUrlToHistoryList:textField.text];
        [self.historyTableView reloadData];
        [textField endEditing:YES];
        
        PlayerViewController *palyVC = [[PlayerViewController alloc] init];
        palyVC.hidesBottomBarWhenPushed = YES;
        [palyVC playWithVideoUrl:textField.text];
        [self.navigationController presentViewController:palyVC animated:YES completion:^{
            
        }];
        
    } else {
        [SVProgressHUD showErrorWithStatus:@"网址不能为空"];
    }
    
    return YES;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入要播放的网址";
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeySearch;
    }
    return _textField;
}

- (UITableView *)historyTableView {
    if (!_historyTableView) {
        _historyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _historyTableView.backgroundColor = [UIColor clearColor];
        _historyTableView.dataSource = self;
        _historyTableView.delegate = self;
        _historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _historyTableView.rowHeight = 35;
    }
    return _historyTableView;
}

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = [NSMutableArray array];
        [_historyArray addObjectsFromArray:[FAPNetworkViewController getAllHistoryList]];
    }
    return _historyArray;
}

+ (void)addUrlToHistoryList:(NSString *)url
{
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[FAPNetworkViewController getAllHistoryList]];
    
    if ([muarr containsObject:url]) {
        
    } else {
        [muarr addObject:url];
        NSString *key = @"Net_Url_History";
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)delUrlFromHistoryList:(NSString *)url {
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[FAPNetworkViewController getAllHistoryList]];
    if ([muarr containsObject:url]) {
        [muarr removeObject:url];
        NSString *key = @"Net_Url_History";
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        
    }
}

+ (NSArray *)getAllHistoryList
{
    
    NSString *key = @"Net_Url_History";
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    
    if (array) {
        return array;
    }
    
    return nil;
}

@end
