//
//  FIleSystemMainView.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FIleSystemMainView.h"
#import "FileSystemCollectionViewCell.h"
#import "FileSystemNoDataView.h"
#import "FileManagerTool.h"

@interface FIleSystemMainView()<UICollectionViewDelegate,UICollectionViewDataSource,FileSysCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) FileSystemNoDataView *noDataView;

@end

@implementation FIleSystemMainView

- (FileSystemNoDataView*)noDataView{
    if (!_noDataView) {
        _noDataView = [[FileSystemNoDataView alloc] initWithFrame:CGRectZero desc:@"还没有创建文件夹~"];
    }
    return _noDataView;
}

- (UICollectionView*)collectionView{
    if (!_collectionView) {
        CGFloat itemWidth = SCREEN_Width/3 - 24;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(itemWidth, itemWidth);
        layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"FileSystemCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"mainCell"];
        UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
        refresh.tintColor = [UIColor whiteColor];
        [refresh addTarget:self action:@selector(headerRefresh) forControlEvents:UIControlEventValueChanged];
        _collectionView.refreshControl = refresh;
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

- (void)headerRefresh{
    NSMutableArray *dataArray = [[FileManagerTool sharedManagerTool] contentsOfDirectory:DocumentsPath];
    [self updateFileWithDataArray:dataArray];
}

- (void)initSubViews{
    self.backgroundColor = ASOColorBackGround;
    self.dataArray = [NSMutableArray array];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FileSystemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
    cell.delegate = self;
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FileSystemCollectionViewCell" owner:self options:nil] firstObject];
    }
        
    NSString *directoryName = self.dataArray[indexPath.row];
    cell.directoryNameLabel.text = directoryName;
    
    if ([directoryName isEqualToString:@"Download"]) {
        cell.iconImageView.image = [UIImage imageNamed:@"xiazai"];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didSelecteFileItemAtIndexPath:)]) {
        [self.delegate didSelecteFileItemAtIndexPath:indexPath];
    }
}

- (void)editFileView{
    for (FileSystemCollectionViewCell *cell in _collectionView.visibleCells) {
        [cell showDeleteIcon];
    }
}

- (void)endEditFileView{
    for (FileSystemCollectionViewCell *cell in _collectionView.visibleCells) {
        [cell hideDeleteIcon];
    }
}

- (void)updateFileWithDataArray:(NSMutableArray*)dataArray{
    [_collectionView.refreshControl endRefreshing];
    if (dataArray.count == 0) {
        [self addSubview:self.noDataView];
        [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }else{
        [self.noDataView removeFromSuperview];
    }
    self.dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)didClickedDeleteButton:(UICollectionViewCell *)cell{
    FileSystemCollectionViewCell *fileCell = (FileSystemCollectionViewCell*)cell;
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:fileCell];
    
    if ([self.delegate respondsToSelector:@selector(didDeleteFileItemAtIndexPath:collectionItem:)]) {
        [self.delegate didDeleteFileItemAtIndexPath:indexPath collectionItem:fileCell];
    }
}

@end
