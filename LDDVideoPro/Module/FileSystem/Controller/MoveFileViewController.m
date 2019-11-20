//
//  MoveFileViewController.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/19.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "MoveFileViewController.h"
#import "FileManagerTool.h"

@interface MoveFileViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MoveFileViewController

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
        _tableView.rowHeight = 50;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"移动到文件夹";
    _dataArray = [NSMutableArray array];
    NSMutableArray *array = [[FileManagerTool sharedManagerTool] contentsOfDirectory:DocumentsPath];
    
    for (NSString *dirName in array) {
        if ([[FileManagerTool sharedManagerTool] directoryIsExist:dirName]) {
            [_dataArray addObject:dirName];
        }
    }
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_close"] style:UIBarButtonItemStylePlain target:self action:@selector(dismissCurrentVC)];
}

- (void)dismissCurrentVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *dirName = _dataArray[indexPath.row];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"fileIcon_small"];
    cell.textLabel.text = dirName;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    
    UIView *selectedView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedView.backgroundColor = kTabBarBackgroundColor;
    cell.selectedBackgroundView = selectedView;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *dirName = _dataArray[indexPath.row];

    
    if ([dirName isEqualToString:self.originDirectory]) {
        [SVProgressHUD showErrorWithStatus:@"不可移动到当原始文件夹！"];
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否确认将所选文件移到“%@”?",_dataArray[indexPath.row]] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        
        for (NSString *oldPath in self.originPaths) {
            //获取文件旧路径以及设置新路径
            NSString *fileName = [[oldPath componentsSeparatedByString:@"/"] lastObject];
            NSString *newsPath = [[DocumentsPath stringByAppendingPathComponent:dirName] stringByAppendingPathComponent:fileName];
            //移动文件
            if ([[FileManagerTool sharedManagerTool] moveItemAtPath:oldPath toPath:newsPath]) {
                NSLog(@"文件移动成功，oldPath:%@\n newPath:%@ \n 文件名：%@",oldPath,newsPath,fileName);
            }
            
        }
        
        if ([self.delegate respondsToSelector:@selector(didMoveFileSuccessHandler:)]) {
            [self.delegate didMoveFileSuccessHandler:self.originPaths];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
