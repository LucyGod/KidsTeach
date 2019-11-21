//
//  PaymentContentView.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "PaymentContentView.h"
#import "PaymentCollectionViewCell.h"

@interface PaymentContentView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray *_dataArray;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation PaymentContentView

- (UICollectionView*)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_Width*0.7 - 18, 230 - 18);
        layout.sectionInset = UIEdgeInsetsMake(12, 12, 12, 12);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"PaymentCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"payCell"];
    }
    return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    _dataArray = [NSArray array];
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PaymentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"payCell" forIndexPath:indexPath];
    NSDictionary *infoDic = _dataArray[indexPath.row];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PaymentCollectionViewCell" owner:self options:nil] firstObject];
    }
    
    [cell configCell:infoDic];
    
    return cell;
}

- (void)updateContentView:(NSArray*)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}


@end
