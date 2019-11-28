//
//  ImageListViewController.m
//  UncompressTeam
//
//  Created by MAC on 27/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ImageListViewController.h"

@interface ImageListViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *myTableView;
@end

@implementation ImageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"教程";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
