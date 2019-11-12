//
//  FAPBaseTableViewController.m
//  KidTeach
//
//  Created by MAC on 22/10/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPBaseTableViewController.h"
#import "LLNoDataView.h"

@interface FAPBaseTableViewController ()

@end

@implementation FAPBaseTableViewController

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
    [self.myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HEADER"];
}

- (void)setupRefresh{
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

- (void)loadData {
    
}

- (void)loadMoreData {
    
}

- (void)addNothingView:(NSString*)des{
    if (self.dataArray.count ==0) {
        NSString * description = des;
        LLNoDataView *dataView = [[LLNoDataView alloc] initImageWithFrame:self.myTableView.bounds image:[UIImage imageNamed:@"nodata"] description:description canTouch:NO];
        self.myTableView.backgroundView = dataView;
    }else
        self.myTableView.backgroundView = nil;
}

- (void)headerEndRefresh{
    [self.myTableView.mj_header endRefreshing];
}

- (void)footerEndRefresh{
    [self.myTableView.mj_footer endRefreshing];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (nil==cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    return header;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)dealloc
{
    self.myTableView.delegate = nil;
    self.myTableView.dataSource = nil;
}

#pragma mark
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.myTableView) {
        [self.view endEditing:YES];
    }
}

@end
