//
//  ASODetailContentTopView.m
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ASODetailContentTopView.h"
#import "ASODetailContentTopCollectionViewCell.h"

@interface ASODetailContentTopView ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
}

@property (nonatomic,copy) NSString *type;

@end

@implementation ASODetailContentTopView

- (instancetype)initWithFrame:(CGRect)frame contentType:(NSString*)type{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self initData];
        [self initSubViews];
    }
    return self;
}

- (void)initData{
    _dataArray = [NSMutableArray array];
    
    NSString *fileName = @"";
    
    if ([self.type isEqualToString:@"动物"]) {
        fileName = @"animal_k_data";
    }else  if ([self.type isEqualToString:@"水果"]) {
        fileName = @"fruits_k_data";
    }else if ([self.type isEqualToString:@"蔬菜"]) {
        fileName = @"vegetables_k_data";
    }else {
        fileName = @"person_k_data";
    }
        
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *dataStock = [NSData dataWithContentsOfFile:path];
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:dataStock options:0 error:nil];
    
    [_dataArray addObjectsFromArray:dataArr];
    
}


- (void)updateTopView:(NSArray*)dataArray{
    
}

- (void)initSubViews{
    self.backgroundColor = [UIColor clearColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(40, 40);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"ASODetailContentTopCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"topItem"];
    
    [self addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ASODetailContentTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topItem" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ASODetailContentTopCollectionViewCell" owner:self options:nil] firstObject];
    }
    
    NSDictionary *dataDic = _dataArray[indexPath.row];
    [cell configCell:dataDic];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld个item",indexPath.row);
    NSDictionary *paramDic = _dataArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(didSelectdTopViewItemAtIndexpath:param:)]) {
        [self.delegate didSelectdTopViewItemAtIndexpath:indexPath param:paramDic];
    }
}

@end
