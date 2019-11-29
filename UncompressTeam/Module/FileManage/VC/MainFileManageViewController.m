//
//  FileManageViewController.m
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "MainFileManageViewController.h"
#import "FileSystemHandle.h"
#import "FileCollectionViewController.h"
#import "ShowTypePopViewController.h"
#import "AppDelegate.h"
#import "SecondViewController.h"
#import "FileSystemHandle.h"
#import "CollectionViewCell.h"
#import "FileManagerTool.h"
#define BLUECOLOR [UIColor colorWithDisplayP3Red:51/255.0 green:171/255.0 blue:238/255.0 alpha:1]
#import "FileManagerTool.h"
#import "FileIcon.h"
@interface MainFileManageViewController () <ShowTypePopViewControllerDelegate, UIPopoverPresentationControllerDelegate, UIGestureRecognizerDelegate, UISearchBarDelegate>
{
    UICollectionViewFlowLayout *flowlayout;
    FileCollectionViewController *collectionController;
    UIBarButtonItem *editBtn;
    UIBarButtonItem *menuBtn;
    UIBarButtonItem *backBtn;
    UIBarButtonItem *deleteBtn;
    UIBarButtonItem *spaceItem;
    UIBarButtonItem *listBtn;
    UIBarButtonItem *searchBtn;
    UIBarButtonItem *addBtn;
    UIBarButtonItem *copyBtn;
    UIBarButtonItem *cuteBtn;
    UIBarButtonItem *deleteBarBtn;
    UIBarButtonItem *zipBtn;
    UIBarButtonItem *saveBtn;
    
    AppDelegate *appDelegate;
    BOOL isDirectoryFirst;//是否勾选目录优先
    BOOL isDesc;//是否升序
    NSInteger selectedSortType;//选择的排序方式:1:名称 2:大小 3:日期 4:类型
    NSMutableArray *dataArr;//页面原始数据
}
@property (nonatomic ,strong) UISegmentedControl *segmentedControl;

@end

@implementation MainFileManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initSegContolView];
    [self configMainView];
    [self setNavItems];
    [self configToolBar];
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    isDirectoryFirst = false;
    isDesc = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    appDelegate.viewController = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 1];
    [collectionController.collectionView reloadData];
}

#pragma mark - 初始化(主视图 导航栏 工具栏)
- (instancetype)initWithFile:(NSString*)path fileName: (NSString*)name {
    self = [super init];
    if (self) {
        if (path && name) {
            self.sourcePath = path;
            self.fileTitle = name;
        }
    }
    return self;
}
-(void)initSegContolView
{
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"默认", @"名称",@"大小",@"日期",@"类型"]];
    self.segmentedControl.frame = CGRectMake(10, 5 , SCREEN_Width-20, 40);
    NSDictionary *norDic = [NSDictionary dictionaryWithObjectsAndKeys:ASOColorTheme,NSForegroundColorAttributeName,[UIFont systemFontOfSize:14],NSFontAttributeName ,nil];
    //    self.segmentedControl.layer.masksToBounds = YES;
    //    self.segmentedControl.layer.borderColor = ASOColorTheme.CGColor;
    //    self.segmentedControl.layer.borderWidth = 1;
    [self.segmentedControl setTitleTextAttributes:norDic forState:UIControlStateNormal];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
}
- (void)selectItem:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex != 0) {
        selectedSortType = sender.selectedSegmentIndex;
    }
    [collectionController sortByTypes:selectedSortType isDesc:isDesc isDirectoryFirst:isDirectoryFirst];
}
- (void)configMainView {
    flowlayout = [[UICollectionViewFlowLayout alloc] init];
    collectionController = [[FileCollectionViewController alloc] initWithCollectionViewLayout:flowlayout];
    if (self.sourcePath) {
        [collectionController initFilePath:self.sourcePath];
    } else {
        //                NSString *homePath = NSHomeDirectory();
        //                [collectionController initFilePath:DocumentsPath];
        
        [collectionController initFilePath:DocumentsPath];
        //    [collectionController initFilePath:[NSString stringWithFormat:@"%@/Resource",[[NSBundle mainBundle] pathForResource:@"Resources" ofType:@"bundle"]]];
    }
    [self addChildViewController:collectionController];
    [self.view addSubview:collectionController.view];
    
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressAction:)];
    longpress.minimumPressDuration = 0.5;
    [collectionController.collectionView addGestureRecognizer:longpress];
    dataArr = collectionController.dataArr;
}
- (void)pressAction:(UILongPressGestureRecognizer *)longPressGesture
{
    if (longPressGesture.state == UIGestureRecognizerStateBegan)//手势结束
    {
        CGPoint point = [longPressGesture locationInView:collectionController.collectionView];
        NSIndexPath *currentIndexPath = [collectionController.collectionView indexPathForItemAtPoint:point];
        NSString *nameStr = dataArr[currentIndexPath.row][@"name"];
        NSString *pathStr = dataArr[currentIndexPath.row][@"path"];
        
        [FileSystemHandle fileHandleAlertShowFileName:nameStr FilePath:pathStr collectionVC:collectionController withVC:self ];
    }
}
-(void)setNavItems {
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = BLUECOLOR;
    if (self.fileTitle) {
        self.navigationItem.title = self.fileTitle;
    } else {
        self.navigationItem.title = @"解压专家";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithDisplayP3Red:51/255.0 green:171/255.0 blue:238/255.0 alpha:1], NSForegroundColorAttributeName, nil]];
    [self.navigationItem setHidesBackButton:YES];
    editBtn = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(pushEditView)];
    self.navigationItem.rightBarButtonItem = editBtn;
    
    menuBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"app-menu"] style:UIBarButtonItemStylePlain target:self action:@selector(pushSetting)];
    backBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    if (self.sourcePath) {
        self.navigationItem.leftBarButtonItem = backBtn;
    } else {
        self.navigationItem.leftBarButtonItem = menuBtn;
    }
}

-(void)configToolBar {
    [self.navigationController setToolbarHidden:NO animated:YES];
    self.navigationController.toolbar.barTintColor = [UIColor whiteColor];
    self.navigationController.toolbar.tintColor = ASOColorTheme;
    spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    listBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"liebiao"] style:UIBarButtonItemStylePlain target:self action:@selector(pop:)];
    listBtn.tag = 0;
    searchBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"sousuo"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
    addBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"add"] style:UIBarButtonItemStylePlain target:self action:@selector(addAction)];
    
    [self setToolbarItems:@[spaceItem,listBtn, spaceItem, addBtn, spaceItem, searchBtn, spaceItem ]];
}
- (void)addAction
{
    [FileSystemHandle addActionShowViewFilePath:_sourcePath collectionVC:collectionController withVC:self];
}
#pragma mark  push设置界面
- (void)pushSetting
{
    SecondViewController *second = [[SecondViewController alloc] init];
    second.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:second animated:YES];
}
#pragma mark - 编辑视图(全选 删除)
- (void)pushEditView {
    collectionController.isEditing = !collectionController.isEditing;
    if (collectionController.isEditing) {
        collectionController.collectionView.allowsMultipleSelection = YES;
        [self initEditingView];
    } else {
        //编辑状态下全选完直接点击完成退出时将全选状态取消
        if (self.isSelectAll) {
            self.isSelectAll = !self.isSelectAll;
        }
        [self setNavItems];
        [self configToolBar];
        //退出编辑状态时清空选择的行数
        collectionController.selectedNum = 0;
        //退出编辑状态时清空删除的数据
        [collectionController.selectedArr removeAllObjects];
        collectionController.collectionView.allowsMultipleSelection = NO;
        [collectionController.collectionView  selectItemAtIndexPath:nil animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        [collectionController.collectionView reloadData];
    }
}

#pragma mark 编辑
-(void)initEditingView {
    [collectionController.collectionView reloadData];
    [editBtn setTitle:@"完成"];
    self.navigationItem.title = @"选择项目";
    self.selectAllBtn = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(selectAllBtn:)];
    self.navigationItem.leftBarButtonItem = self.selectAllBtn;
    
    deleteBtn = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(handleData:)];
    copyBtn = [[UIBarButtonItem alloc]initWithTitle:@"复制" style:UIBarButtonItemStylePlain  target:self action:@selector(handleData:)];
    zipBtn = [[UIBarButtonItem alloc] initWithTitle:@"压缩" style:UIBarButtonItemStylePlain  target:self action:@selector(handleData:)];
    saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain  target:self action:@selector(handleData:)];
    [self setToolbarItems:@[deleteBtn,spaceItem, copyBtn,spaceItem,  zipBtn,spaceItem, saveBtn] animated:YES];
}

//全选
- (void)selectAllBtn:(id)sender {
    self.isSelectAll = !self.isSelectAll;
    if (self.isSelectAll) {
        [self.selectAllBtn setTitle:@"取消"];
        collectionController.selectedNum = collectionController.dataArr.count;
        self.navigationItem.title = [NSString stringWithFormat:@"已选择%@个项目",[[NSNumber numberWithLong:collectionController.selectedNum] stringValue]];
        for (int i = 0; i< collectionController.dataArr.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [collectionController.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
        if (collectionController.selectedArr.count >0) {
            [collectionController.selectedArr removeAllObjects];
        }
        [collectionController.selectedArr addObjectsFromArray:collectionController.dataArr];
    } else {
        //退出列表模式下的编辑视图
        if (!collectionController.isCell) {
            [collectionController.collectionView reloadData];
        }
        [self.selectAllBtn setTitle:@"全选"];
        self.navigationItem.title = @"选择项目";
        collectionController.selectedNum = 0;
        //cell全部变成非选中状态
        [collectionController.collectionView  selectItemAtIndexPath:nil animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        [collectionController.selectedArr removeAllObjects];
    }
}

//处理弹框
- (void)handleData:(UIBarButtonItem*)btn {
    UIBarButtonItem *cuBtn = (UIBarButtonItem*)btn;
    NSString *nameStr = cuBtn.title;
    if (collectionController.selectedArr.count > 0) {
        NSString *i = [[NSString alloc] init];
        if (collectionController.selectedArr.count == 1) {
            i = [NSString stringWithFormat:@"%@项目",nameStr];
        } else {
            i = [NSString stringWithFormat:@"%@%ld个项目", nameStr,(long)collectionController.selectedNum];
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:i style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){
            [self confirmHandle:nameStr];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:confirmAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma mark 确认操作：删除、复制、压缩、保存
//确认操作：删除、复制、压缩、保存
- (void)confirmHandle:(NSString*)str {
    self.navigationItem.title = @"选择项目";
    if ([str isEqualToString:@"删除"]) {
        [collectionController.dataArr removeObjectsInArray:collectionController.selectedArr];
        for (NSDictionary *dic in collectionController.selectedArr) {
            [[FileManagerTool sharedManagerTool] deleteFileAtFilePath:dic[@"path"]];
        }
        [collectionController.selectedArr removeAllObjects];
        [collectionController.collectionView  selectItemAtIndexPath:nil animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        
        [collectionController.collectionView reloadData];
    }
    else if ([str isEqualToString:@"复制"])
    {
        for (NSDictionary *dic in collectionController.selectedArr) {
            NSString *fileName = dic[@"name"];
            NSString *path = dic[@"path"];
            //拷贝文件夹
            if ([[FileManagerTool sharedManagerTool] directoryIsExist:fileName]) {
                NSString *newName = [fileName stringByAppendingString:@"(副本)"];//新的文件名
                NSString *newSubPath = [[path componentsSeparatedByString:fileName] firstObject];
                NSString *newFilePath = [newSubPath stringByAppendingPathComponent:newName];
                [[FileManagerTool sharedManagerTool] copyItemAtPath:path toPath:newFilePath];
            }else{
                //拷贝文件
                NSString *originlName = [[fileName componentsSeparatedByString:@"."] firstObject]; //获取文件名
                NSString *originlExtension = [[fileName componentsSeparatedByString:@"."] lastObject];//文件后缀
                NSString *newName = [originlName stringByAppendingString:@"(副本)"];//新的文件名
                NSString *newFullName = [[newName stringByAppendingString:@"."] stringByAppendingString:originlExtension];//新的文件名加后缀
                NSString *newSubPath = [[path componentsSeparatedByString:fileName] firstObject];
                NSString *newFilePath = [newSubPath stringByAppendingPathComponent:newFullName];
                [[FileManagerTool sharedManagerTool] copyItemAtPath:path toPath:newFilePath];
            }
        }
        [collectionController reloadData];
    }
    else if ([str isEqualToString:@"压缩"])
    {
        for (NSDictionary *dic in collectionController.selectedArr) {
            NSString *fileName = dic[@"name"];
            NSString *path = dic[@"path"];
            
            //仅支持zip格式压缩
            NSInteger fileIndex = 0;
            NSString *absoluteName = [[fileName componentsSeparatedByString:@"."] firstObject];
            NSString *subPath = [[path componentsSeparatedByString:fileName] firstObject];
            
            NSString *compressName = [[absoluteName stringByAppendingString:@"."] stringByAppendingString:@"zip"];
            NSString *fullCompressPath = [subPath stringByAppendingPathComponent:compressName];
            
            while ([[FileManagerTool sharedManagerTool] fileIsExistWithFullPath:fullCompressPath]) {
                fileIndex ++;
                absoluteName = [[[fileName componentsSeparatedByString:@"."] firstObject] stringByAppendingString:[NSString stringWithFormat:@"%ld",fileIndex]];
                compressName = [[absoluteName stringByAppendingString:@"."] stringByAppendingString:@"zip"];
                fullCompressPath = [subPath stringByAppendingPathComponent:compressName];
            }
            
            [self archiveFileWithPath:path VC:collectionController archiveDiectionName:compressName];
        }
        
    }
    else if ([str isEqualToString:@"保存"])
    {
        BOOL isContainOtherFile = NO;
        NSMutableArray *saveImageArray = [NSMutableArray array];
        
        for (NSDictionary *dic in collectionController.selectedArr) {
            NSString *path = dic[@"path"];
            NSString *fileFullName = [[path componentsSeparatedByString:@"/"] lastObject];   //文件全名
            NSString *fileExtension = [fileFullName pathExtension];  //文件后缀
            
            if (![FileIcon isImage:[fileExtension lowercaseString]]) {
                //不是图片
                isContainOtherFile = YES;
            }else{
                //要保存到相册里的图片
                [saveImageArray addObject:dic];
            }
        }
        
        if (isContainOtherFile) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您选择的文件中包含非图片类型，只有图片文件可以保存到系统相册，是否继续操作？" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self saveImageWithDataArray:saveImageArray];
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            [self saveImageWithDataArray:saveImageArray];
        }
    }
}


/// 压缩文件
/// @param filePath 原文件路径
/// @param vc 刷新数据的VC
/// @param dirName 压缩后的文件名称
- (void)archiveFileWithPath:(NSString*)filePath VC:(FileCollectionViewController*)vc archiveDiectionName:(NSString*)dirName{
    
    SARUnArchiveANY *archive = [[SARUnArchiveANY alloc]initWithPath:filePath];
    
    archive.completionBlock = ^(NSArray *filePaths) {
        [SVProgressHUD dismiss];
        [vc reloadData];
        
        NSLog(@"压缩文件成功后的回调%@",filePaths);
    };
    
    archive.failureBlock = ^{
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"压缩文件失败!"];
        NSLog(@"压缩文件失败");
    };
    
    [archive compressFileWithCompressType:[dirName pathExtension] fileName:dirName];
}

/// 将图片保存到相册
/// @param dataArray 图片信息array
- (void)saveImageWithDataArray:(NSMutableArray*)dataArray{
    if (dataArray.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"已保存0个文件"];
        return;
    }
    [SVProgressHUD showWithStatus:@"保存中……"];
    for (NSDictionary *imageInfoDic in dataArray) {
        NSString *path = imageInfoDic[@"path"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        UIImage *image = [UIImage imageWithData:data];
        //参数1:图片对象
        //参数2:成功方法绑定的target
        //参数3:成功后调用方法
        //参数4:需要传递信息(成功后调用方法的参数)
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
        [SVProgressHUD showInfoWithStatus:msg];
        
    }else{
        msg = @"图片已成功保存到相册，请查看。" ;
        [SVProgressHUD showSuccessWithStatus:msg];
    }
}

#pragma mark - 切换视图模式 排序
- (void)pop:(UIBarButtonItem*)btn {
    ShowTypePopViewController *popV = [[ShowTypePopViewController alloc] initWithPopView:btn isDirectoryFirst:(BOOL)isDirectoryFirst isDesc:(BOOL)isDesc selectedSortType:(NSInteger)selectedSortType];
    popV.delegate = self;
    [self presentViewController:popV animated:YES completion:nil];
}

- (void)chooseShowType:(ShowTypePopViewController *)controller didSelectAtIndex:(int)index btnTag:(int)btnTag isDirectoryFirst:(BOOL)isDF isDesc:(BOOL)isDc {
    isDirectoryFirst = isDF;
    isDesc = isDc;
    switch (btnTag) {
        case 0:
            switch (index) {
                case 0:
                    collectionController.isCell = NO;
                    [collectionController.collectionView reloadData];
                    break;
                case 1:
                    collectionController.isCell = YES;
                    [collectionController.collectionView reloadData];
                    break;
                default:
                    break;
            }
            break;
            //排序
        case 1:
            if (index != 0) {
                selectedSortType = index;
            }
            [collectionController sortByTypes:selectedSortType isDesc:isDesc isDirectoryFirst:isDirectoryFirst];
        default:
            break;
    }
}

#pragma mark - 搜索
//搜索
- (void)search {
    //页面原始数据
    dataArr = collectionController.dataArr;
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    CGRect frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, 40);
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:frame];
    searchBar.placeholder = @"搜索内容";
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    searchBar.tintColor = BLUECOLOR;
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    [cancleBtn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    if(@available(iOS 11.0, *)) {
        [[searchBar.heightAnchor constraintEqualToConstant:44] setActive:YES];
    }
    self.navigationItem.titleView = searchBar;
    [searchBar becomeFirstResponder];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)cancelSearch {
    self.navigationItem.titleView = nil;
    if (self.sourcePath) {
        self.navigationItem.leftBarButtonItem = backBtn;
    } else {
        self.navigationItem.leftBarButtonItem = menuBtn;
    }
    self.navigationItem.rightBarButtonItem = editBtn;
    collectionController.dataArr = dataArr;
    [collectionController.collectionView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSMutableArray *resultArr = [NSMutableArray array];
    if (dataArr) {
        if (!searchText.length) {
            resultArr = dataArr;
        } else {
            for (int i = 0; i< dataArr.count; i++){
                NSString *str = dataArr[i][@"name"];
                if ([str.lowercaseString containsString:searchText.lowercaseString]) {
                    [resultArr addObject:dataArr[i]];
                }
            }
        }
    }
    collectionController.dataArr = resultArr;
    [collectionController.collectionView reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - 目录操作(进入下级目录 返回上级目录)
//进入文件夹
- (void)enterFolder: (NSString*)path fileName: (NSString*)name {
    MainFileManageViewController *viewCtrl = [[MainFileManageViewController alloc] initWithFile:path fileName:name];
    appDelegate.viewController = viewCtrl;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    //不是第一个视图时设置左拉手势返回上一个视图
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

//左拉手势返回上一个视图后执行
- (void)viewWillDisappear:(BOOL) animated {
    //切换视图时退出编辑状态
    if (collectionController.isEditing) {
        [self pushEditView];
    }
    //切换视图时退出搜索状态
    [self cancelSearch];
}

//返回上级菜单
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
