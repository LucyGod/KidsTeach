//
//  MainMusicViewController.m
//  KidTeach
//
//  Created by mac on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "MusicViewController.h"
#import "MusicModel.h"
#import "AudioPlayerController.h"
#import "NetworkTool.h"
#import "MusicTableViewCell.h"
#import "UITableViewCell+UMReusable.h"
#import "MusicHeadView.h"
#import "UIResponder+responder.h"
#import "UIImage+ImageEffects.h"
@interface MusicViewController ()<UITableViewDelegate ,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong) MusicHeadView *headView;
@end

static NSString *songIdentifier = @"songCellIdentifier";
@implementation MusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(15, 15, 30, 30);
    [closeBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(dismis) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
}
- (void)dismis
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
-(void)LoadDataTypeStr:(NSString *)str
{
    NSString *jsonStr = [[NSBundle mainBundle]pathForResource:str?str:@"tangshi" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:jsonStr];
    
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in dataDic[@"data"]) {
        MusicModel *model = [[MusicModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArr addObject:model];
    }
    self.headView.countLabel.text = [NSString stringWithFormat:@"共 %ld 首",self.dataArr.count];
    [self.tableView reloadData];
}
-(MusicHeadView *)headView
{
    if (!_headView) {
        _headView = [[[NSBundle mainBundle] loadNibNamed:@"MusicHeadView" owner:self options:nil] lastObject];
    }
    return _headView;
}
-(void)responderWithName:(NSString *)name userInfo:(NSDictionary *)info
{
    if ([name isEqualToString:@"headView"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void)setNameStr:(NSString *)nameStr
{
    _nameStr = nameStr;
    self.headView.NameLabel.text = nameStr;
    self.headView.imgView.image = [UIImage imageNamed:nameStr];
    self.headView.bgImgView.image = [[UIImage imageNamed:nameStr] applyDarkEffect];
    NSInteger rand = arc4random() % 10000+100;
    self.headView.playCountLabel.text = [NSString stringWithFormat:@"%ld 次",rand];
}
-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, ScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicTableViewCell *cell = [MusicTableViewCell um_cellWithTableView:tableView];
    MusicModel *model = [[MusicModel alloc] init];
    model = [self.dataArr objectAtIndex:indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.coverurl] placeholderImage:[UIImage imageNamed:@"kuang_sz02"]];
//    cell.BgImgView.image = [[UIImage imageNamed:_nameStr] applyExtraLightEffect];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",  model.audio_name];
    cell.speLineView.backgroundColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:_nameStr] applyExtraLightEffect]];
    return cell;
}

// 音乐列表cell点击跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    AudioPlayerController *audio = [AudioPlayerController audioPlayerController];
    [audio initWithArray:self.dataArr index:indexPath.row];
    audio.underImageView.image = [[UIImage imageNamed:_nameStr] applyDarkEffect];
    [self presentViewController:audio animated:YES completion:^{
        
    }];
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
