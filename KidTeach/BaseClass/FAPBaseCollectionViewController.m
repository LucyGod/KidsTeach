//
//  FAPBaseCollectionViewController.m
//  KidTeach
//
//  Created by MAC on 22/10/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPBaseCollectionViewController.h"
#import "LLNoDataView.h"

@interface FAPBaseCollectionViewController ()

@end

@implementation FAPBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _myCollectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:collectionView];
        collectionView;
    });
    [_myCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}

- (void)setupRefresh{
    
    WEAKSELF
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myCollectionView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    
    self.myCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

- (void)loadData {
    
}

- (void)loadMoreData {
    
}

- (void)headerEndRefresh{
    [self.myCollectionView.mj_header endRefreshing];
}

- (void)foooterEndRefresh{
    [self.myCollectionView.mj_footer endRefreshing];
}

- (void)addNothingView{
    if (self.dataArray.count ==0) {
        NSString * description = @"暂无数据";
        LLNoDataView *dataView = [[LLNoDataView alloc] initImageWithFrame:self.myCollectionView.bounds image:[UIImage imageNamed:@"nodata"] description:description canTouch:NO];
        self.myCollectionView.backgroundView = dataView;
    }else
        self.myCollectionView.backgroundView = nil;
}

#pragma mark - CollectionDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    return cell;
    
    
}


//设置每个 UICollectionView 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    return CGSizeMake((self.view.frame.size.width-45)/2, (self.view.frame.size.width-45)*1.2/2+20);
}

//定义每个UICollectionView 的间距

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0,0);
    
}


//定义每个UICollectionView 的纵向间距
//横间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.01;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
