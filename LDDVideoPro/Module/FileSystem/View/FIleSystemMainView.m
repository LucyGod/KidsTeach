//
//  FIleSystemMainView.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FIleSystemMainView.h"
#import "FileSystemCollectionViewCell.h"

@interface FIleSystemMainView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation FIleSystemMainView

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
    self.backgroundColor = ASOColorBackGround;
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FileSystemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"FileSystemCollectionViewCell" owner:self options:nil] firstObject];
    }
        
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(didSelecteFileItemAtIndexPath:)]) {
        [self.delegate didSelecteFileItemAtIndexPath:indexPath];
    }
}

@end
