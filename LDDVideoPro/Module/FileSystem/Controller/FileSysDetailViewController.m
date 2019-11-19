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

@interface FileSysDetailViewController ()<FileSystemMoveViewDelegate,DirectoryDetailDelegate>

@property (nonatomic, strong) FileSystemDetailView *detailView;

@property (nonatomic, strong) FileSystemMoveSelecteView *moveSelecteView;


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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"move_right"] style:UIBarButtonItemStyleDone target:self action:@selector(moveItemAction)];


    [self.view addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
//        if (@available(iOS 11.0, *)) {
//            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
//        }
    }];
    
    [self getDirectoryDetailInfo];
}

#pragma mark - 点击文件夹内的内容回调
- (void)didClickedFileWithFilePath:(NSString *)filePath{
    NSString *finalPath = [[DocumentsPath stringByAppendingPathComponent:self.title] stringByAppendingPathComponent:filePath];
    
    NSLog(@"所点击的文件路径L：%@",finalPath);
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
    }
}

- (void)moveFilesCompletionHandler{
    MoveFileViewController *moveFileVC = [[MoveFileViewController alloc] init];
    
    LYTBaseNavigationController *nav = [[LYTBaseNavigationController alloc] initWithRootViewController:moveFileVC];
    
    [self presentViewController:nav animated:YES completion:nil];
//    [self.navigationController pushViewController:moveFileVC animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
