//
//  CircleViewController.m
//  LiveOfBeiJing
//
//  Created by liuyongfei on 2018/11/19.
//

#import "FileSystemViewController.h"
#import "PaymentViewController.h"
#import "FIleSystemMainView.h"
#import "FileManagerTool.h"
#import "FileSysDetailViewController.h"
#import "FileContentViewController.h"

@interface FileSystemViewController ()<FileMainDelegate>{
    BOOL _isEdit;
}

@property (nonatomic,strong) FIleSystemMainView *fileSysView;

@end

@implementation FileSystemViewController

- (FIleSystemMainView*)fileSysView{
    if (!_fileSysView) {
        _fileSysView = [[FIleSystemMainView alloc] initWithFrame:CGRectZero];
        _fileSysView.delegate = self;
    }
    return _fileSysView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editFileSysViewAction)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(addNewFileAction)];
    
    
    [self.view addSubview:self.fileSysView];
    [self.fileSysView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self getFileViewData];
}

- (void)getFileViewData{
    NSMutableArray *dataArray = [[FileManagerTool sharedManagerTool] contentsOfDirectory:DocumentsPath];
    [self.fileSysView updateFileWithDataArray:dataArray];
}


/// 添加新文件夹
- (void)addNewFileAction{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"创建文件夹" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入文件夹名称";
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"创建" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = [alertController.textFields firstObject];
        
        NSLog(@"%@",textField.text);
        if (textField.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"文件夹名称不可为空！"];
            return ;
        }
        if ([[FileManagerTool sharedManagerTool] directoryIsExist:textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"该文件夹已经存在！"];
            return;
        }
        
        //创建文件夹
        [[FileManagerTool sharedManagerTool] createDirectoryWithDirectoryName:textField.text];
        
        [self getFileViewData];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)editFileSysViewAction{
    //    NSMutableArray *dataArray = [[FileManagerTool sharedManagerTool] contentsOfDirectory:DocumentsPath];
    //    if (dataArray.count == 0) {
    //
    //
    //    }else{
    _isEdit = !_isEdit;
    if (_isEdit) {
        [self.navigationItem.rightBarButtonItem setTitle:@"完成"];
        [self.fileSysView editFileView];
    }else{
        [self.navigationItem.rightBarButtonItem setTitle:@"编辑"];
        [self.fileSysView endEditFileView];
    }
    //    }
}

#pragma mark - FileMainDelegate

/// 选择了某个文件夹
/// @param indexPath indexpath
- (void)didSelecteFileItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_isEdit) {
        return;
    }
    
    NSMutableArray *dataArray = [[FileManagerTool sharedManagerTool] contentsOfDirectory:DocumentsPath];
    NSString *dirName = dataArray[indexPath.row];
    
    if ([[FileManagerTool sharedManagerTool] directoryIsExist:dirName]) {
        FileSysDetailViewController *detailVC = [[FileSysDetailViewController alloc] init];
        detailVC.title = dirName;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    }else{
        NSString *filePath = [DocumentsPath stringByAppendingPathComponent:dirName];
        FileContentViewController *contentVC = [[FileContentViewController alloc] init];
        contentVC.hidesBottomBarWhenPushed = YES;
        contentVC.filePath = filePath;
        [self.navigationController pushViewController:contentVC animated:YES];
    }
}


/// 删除文件夹
/// @param indexPath indexpath
- (void)didDeleteFileItemAtIndexPath:(NSIndexPath *)indexPath collectionItem:(nonnull FileSystemCollectionViewCell *)cell{
    NSMutableArray *dataArray = [[FileManagerTool sharedManagerTool] contentsOfDirectory:DocumentsPath];
    NSString *dirName = dataArray[indexPath.row];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除文件夹将会同时删除文件夹下的文件，是否确认删除？" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView animateWithDuration:0.3 animations:^{
            cell.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
        } completion:^(BOOL finished){
//            cell.hidden = YES;
        }];
        
        if ([[FileManagerTool sharedManagerTool] deleteFileAtFilePath:[DocumentsPath stringByAppendingPathComponent:dirName]]) {
            [self getFileViewData];
            cell.transform = CGAffineTransformMakeScale(1.0, 1.0);

        }
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
