//
//  MusicListViewController.m
//  KidTeach
//
//  Created by mac on 2019/11/12.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "MusicHomeViewController.h"
#import "UIResponder+responder.h"
#import "MusicHomeCell.h"
#import "MusicViewController.h"

@interface MusicHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic ,strong)NSMutableArray *imgArr;

@end

@implementation MusicHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    self.title = @"宝宝听一听";
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    [self xq_loadData];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(15, 25, 30, 30);
    [closeBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}
- (void)dismis
{
    [self .navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = YES;
}

-(NSMutableArray *)imgArr
{
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake((SCREEN_Width-20)/2.0, 180);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 10, 5);
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.backgroundColor = [UIColor whiteColor];
         _collectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
        [_collectionView registerNib:[UINib nibWithNibName:@"MusicHomeCell" bundle:nil] forCellWithReuseIdentifier:@"MusicHomeCell"];
    
    }
    
    return _collectionView;
}
-(void)xq_loadData
{
    self.dataSource = [NSMutableArray arrayWithArray:@[@"唐诗三百首",@"宝宝学国学",@"宝宝游戏儿歌",@"宝宝钢琴曲启蒙",@"伊索寓言",@"睡前童话故事",@"声律启蒙",@"十万个为什么"]];
    self.imgArr = [NSMutableArray arrayWithArray:@[@"唐诗三百首",@"宝宝学国学",@"宝宝游戏儿歌",@"宝宝钢琴曲启蒙",@"伊索寓言",@"睡前童话故事",@"声律启蒙",@"十万个为什么"]];
}

#pragma mark -- collectionview代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count?self.dataSource.count:1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *jsonArr = @[@"tangshi",@"dizigui",@"gamesong",@"gangqing",@"yisuo",@"story",@"shenglv",@"why"];
    MusicViewController *music = [[MusicViewController alloc] init];
    
    [music LoadDataTypeStr:jsonArr[indexPath.row]];
    music.nameStr = self.dataSource[indexPath.row];
    [self presentViewController:music animated:YES completion:^{
        
    }];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MusicHomeCell" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
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