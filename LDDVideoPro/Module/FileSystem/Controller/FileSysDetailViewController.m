//
//  FileSysDetailViewController.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileSysDetailViewController.h"
#import "FileSystemDetailView.h"
#import "FileManagerTool.h"
#import "FileSystemMoveSelecteView.h"
#import "MoveFileViewController.h"

@interface FileSysDetailViewController ()<FileSystemMoveViewDelegate,DirectoryDetailDelegate,MoveFileSuccessDelegate>

@property (nonatomic, strong) FileSystemDetailView *detailView;

@property (nonatomic, strong) FileSystemMoveSelecteView *moveSelecteView;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation FileSysDetailViewController

- (FileSystemMoveSelecteView*)moveSelecteView{
    if (!_moveSelecteView) {
        _moveSelecteView = [[FileSystemMoveSelecteView alloc] initWithFrame:CGRectZero];
        _moveSelecteView.delegate = self;
    }
    return _moveSelecteView;
}

- (FileSystemDetailView*)detailView{
    if (!_detailView) {
        _detailView = [[FileSystemDetailView alloc] initWithFrame:CGRectZero];
        _detailView.delegate = self;
    }
    return _detailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"move_right"] style:UIBarButtonItemStyleDone target:self action:@selector(moveItemAction)];


    [self.view addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self getDirectoryDetailInfo];
}

#pragma mark - 点击文件夹内的内容回调
- (void)didClickedFileWithFilePath:(NSString *)filePath{
    NSString *finalPath = [[DocumentsPath stringByAppendingPathComponent:self.title] stringByAppendingPathComponent:filePath];
    
    NSLog(@"所点击的文件路径L：%@",finalPath);
}

- (void)updateSelectedData:(NSMutableArray *)selectedArray{
    NSLog(@"所选数据条数：%ld\n所选数据：%@",selectedArray.count,selectedArray);
    [_moveSelecteView updateSelectedCount:selectedArray];
    
    [self.dataArray removeAllObjects];

    for (NSString *fileNmae in selectedArray) {
        NSString *originPath = [[DocumentsPath stringByAppendingPathComponent:self.title] stringByAppendingPathComponent:fileNmae];
        
        [self.dataArray addObject:originPath];
    }
    
}

/// 移动文件
- (void)moveItemAction{
    BOOL isEdit = !self.detailView.tableView.isEditing;
    [self.detailView.tableView setEditing:isEdit animated:YES];
    
    if (isEdit) {
        //显示moveSelecteView
        [self.view addSubview:self.moveSelecteView];
        [self.moveSelecteView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.equalTo(@(NavMustAdd + 50));
        }];
    }else{
        [self.moveSelecteView removeFromSuperview];
        self.moveSelecteView = nil;
    }
}

- (void)moveFilesCompletionHandler{
    MoveFileViewController *moveFileVC = [[MoveFileViewController alloc] init];
    moveFileVC.originPaths = self.dataArray;
    moveFileVC.originDirectory = self.title;
    moveFileVC.delegate = self;
    LYTBaseNavigationController *nav = [[LYTBaseNavigationController alloc] initWithRootViewController:moveFileVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)getDirectoryDetailInfo{
    NSString * dirPath = [DocumentsPath stringByAppendingPathComponent:self.title];
    if ([[FileManagerTool sharedManagerTool] directoryIsExist:self.title]) {
              
        NSMutableArray * pathArray = [[FileManagerTool sharedManagerTool] contentsOfDirectory:dirPath];
        
        [self.detailView updateDetailView:pathArray];

    }else{
        [SVProgressHUD showErrorWithStatus:@"文件目录不存在！"];
    }
}

#pragma mark - 移动文件成功的回调
- (void)didMoveFileSuccessHandler:(NSMutableArray *)originPaths{
    NSLog(@"移动文件成功，文件原始路径:%@",originPaths);
    
    [_moveSelecteView updateSelectedCount:[NSMutableArray array]];

    [self moveItemAction];
    //刷新数据
    [self getDirectoryDetailInfo];
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
