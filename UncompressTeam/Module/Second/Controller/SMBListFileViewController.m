//
//  SMBListFileViewController.m
//  UncompressTeam
//
//  Created by MAC on 28/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "SMBListFileViewController.h"
#import "SMBManager.h"
#import "SMBFileTootListTableViewCell.h"
#import "FileIcon.h"
@interface SMBListFileViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SMBListFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    if (self.file) {
        self.title = self.file.name;
        [self findFile];
    }
    if (self.share) {
        self.title = self.share.name;
        [self findSMB];
    }
    
}

- (void)findSMB {
    [self.share open:^(NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"无法打开此文件"];
        } else {
            [self.share listFiles:^(NSArray<SMBFile *> *files, NSError *error) {
                if (error) {
                    [SVProgressHUD showErrorWithStatus:@"无法打开此文件"];
                    NSLog(@"Unable to list files: %@", error);
                } else {
                    [self.dataArray addObjectsFromArray:files];
                    [self.myTableView reloadData];
                    NSLog(@"Found %lu files", (unsigned long)files.count);
                }
            }];
        }
    }];
}

- (void)findFile {
    [self.file listFiles:^(NSArray<SMBFile *> *files, NSError *error) {
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"无法打开此文件"];
        } else {
            [self.dataArray addObjectsFromArray:files];
            [self.myTableView reloadData];
            NSLog(@"Found %lu files", (unsigned long)files.count);
        }
    }];
}

- (void)dealloc {
    [self.share close:^(NSError * _Nullable error) {
        
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
    SMBFile *file = [self.dataArray objectAtIndex:indexPath.row];
    cell.nameLabel.text = file.name;
    if (file.isDirectory) {
        [cell.iconImageView setImage:[UIImage imageNamed:@"fileIcon_small"]];
    } else {
        [cell.iconImageView setImage:[UIImage imageNamed:getFileIcon(file.name)]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SMBFile *file = [self.dataArray objectAtIndex:indexPath.row];
    if (file.isDirectory) {
        SMBListFileViewController *listFile = [[SMBListFileViewController alloc] init];
        listFile.file = file;
        [self.navigationController pushViewController:listFile animated:YES];
    } else {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path = [documentsPath stringByAppendingPathComponent:file.path];
        NSUInteger bufferSize = 12000;
        NSMutableData *result = [NSMutableData new];
        
        [file open:SMBFileModeRead completion:^(NSError *error) {
            if (error) {
                NSLog(@"Unable to open the file: %@", error);
            } else {
                NSLog(@"File opened: %@", file.name);
                [SVProgressHUD show];
                [file read:bufferSize
                  progress:^BOOL(unsigned long long bytesReadTotal, NSData *data, BOOL complete, NSError *error) {

                    if (error) {
                        NSLog(@"Unable to read from the file: %@", error);
                    } else {
                        [SVProgressHUD showProgress:((double)bytesReadTotal / file.size * 100) status:@"下载中"];
                        NSLog(@"Read %ld bytes, in total %llu bytes (%0.2f %%)",
                              data.length, bytesReadTotal, (double)bytesReadTotal / file.size * 100);
                    
                        if (data) {
                            [result appendData:data];
                        }
                    }
                    
                    if (complete) {
                        [file close:^(NSError *error) {
                            NSLog(@"Finished reading file");
                            [SVProgressHUD dismiss];
                            [SVProgressHUD showSuccessWithStatus:@"下载成功"];
                            [result writeToFile:path atomically:YES];
                        }];
                    }
                    
                    return YES;
                }];
            }
        }];
        
    }
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
