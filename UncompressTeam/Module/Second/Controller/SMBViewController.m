//
//  SMBViewController.m
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "SMBViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "SMBSection0TableViewCell.h"
#import "SMBSection1TableViewCell.h"

@interface SMBViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic, copy) NSArray *nameArray;
@property (nonatomic, copy) NSArray *houlderArray;
@property (nonatomic, copy) NSString *IPAddress;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

@end

@implementation SMBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"SMB";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"链接" style:UIBarButtonItemStylePlain target:self action:@selector(rightClick)];
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
    [_myTableView registerNib:[UINib nibWithNibName:@"SMBSection0TableViewCell" bundle:nil] forCellReuseIdentifier:@"SMBSection0TableViewCell"];
    [_myTableView registerNib:[UINib nibWithNibName:@"SMBSection1TableViewCell" bundle:nil] forCellReuseIdentifier:@"SMBSection1TableViewCell"];
    [_myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HEADER"];
    [self findSMB];
}

- (void)findSMB {
    [[SMBDiscovery sharedInstance] startDiscoveryOfType:SMBDeviceTypeAny added:^(SMBDevice *device) {
        NSLog(@"Device added: %@", device);
    } removed:^(SMBDevice *device) {
        NSLog(@"Device removed: %@", device);
    }];
}

- (void)rightClick {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.nameArray.count;
    } else {
        return 0;
    }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        SMBSection0TableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"SMBSection0TableViewCell" forIndexPath:indexPath];
        cell.titleLabel.text =self.nameArray[indexPath.row];
        cell.contentField.placeholder = self.houlderArray[indexPath.row];
        WEAKSELF
        [cell setSuccess:^(NSString * _Nonnull text) {
            if (indexPath.row == 0) {
                weakSelf.IPAddress = text;
            } else if (indexPath.row == 1) {
                weakSelf.userName = text;
            } else if (indexPath.row == 2) {
                weakSelf.password = text;
            }
        }];
        return cell;
    } else if (indexPath.section == 1) {
        SMBSection1TableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"SMBSection1TableViewCell" forIndexPath:indexPath];
//        cell.titleLabel.text = @"开启";

        return cell;
    }
    return nil;
}

- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSArray arrayWithObjects:@"主机/IP",@"用户名",@"密码", nil];
    }
    return _nameArray;
}

- (NSArray *)houlderArray {
    if (!_houlderArray) {
        _houlderArray = [NSArray arrayWithObjects:@"必填",@"可选",@"可选", nil];
    }
    return _houlderArray;
}

@end
