//
//  FAPBaseCollectionViewController.h
//  KidTeach
//
//  Created by MAC on 22/10/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FAPBaseCollectionViewController : LYTBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView *myCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
- (void)headerEndRefresh;

- (void)foooterEndRefresh;

- (void)loadData;
- (void)loadMoreData;

- (void)addNothingView;

@end

NS_ASSUME_NONNULL_END
