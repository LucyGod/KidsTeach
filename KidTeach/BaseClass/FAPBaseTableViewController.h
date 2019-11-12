//
//  FAPBaseTableViewController.h
//  KidTeach
//
//  Created by MAC on 22/10/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

NS_ASSUME_NONNULL_BEGIN

@interface FAPBaseTableViewController : LYTBaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
- (void)setupRefresh;
- (void)headerEndRefresh;
- (void)footerEndRefresh;

- (void)loadData;
- (void)loadMoreData;

- (void)addNothingView:(NSString*)des;
@end

NS_ASSUME_NONNULL_END
