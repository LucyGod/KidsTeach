//
//  SMBFileTootListViewController.m
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "SMBFileTootListViewController.h"
#import "SMBManager.h"
#import "SMBFileTootListTableViewCell.h"
#import "SMBListFileViewController.h"
@interface SMBFileTootListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation SMBFileTootListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
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
    [_myTableView registerNib:[UINib nibWithNibName:@"SMBFileTootListTableViewCell" bundle:nil] forCellReuseIdentifier:@"SMBFileTootListTableViewCell"];
//    [_myTableView registerNib:[UINib nibWithNibName:@"SMBSection1TableViewCell" bundle:nil] forCellReuseIdentifier:@"SMBSection1TableViewCell"];
    [_myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HEADER"];
    [self findSMB];
}

- (void)findSMB {
    SMBFileServer *fileServer = [SMBManager sharedInstance].fileServer;
    if (fileServer) {
        [fileServer listShares:^(NSArray<SMBShare *> *shares, NSError *error) {
            if (error) {
                NSLog(@"Unable to list the shares: %@", error);
            } else {
                [self.dataArray addObjectsFromArray:shares];
                [self.myTableView reloadData];
//                for (SMBShare *share in shares) {
//                    NSLog(@"Got share: %@", share.name);
//
//                }
            }
        }];
    }
}

- (void)dealloc {
    SMBFileServer *fileServer = [SMBManager sharedInstance].fileServer;
    [fileServer disconnect:^{
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
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
    SMBFileTootListTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"SMBFileTootListTableViewCell" forIndexPath:indexPath];
    SMBShare *share = [self.dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = share.name;
    [cell.iconImageView setImage:[UIImage imageNamed:@"fileIcon_small"]];
//    cell.addressLabel.text = device.host;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SMBShare *share = [self.dataArray objectAtIndex:indexPath.row];
    SMBListFileViewController *listFile = [[SMBListFileViewController alloc] init];
    listFile.share = share;
    [self.navigationController pushViewController:listFile animated:YES];

}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
