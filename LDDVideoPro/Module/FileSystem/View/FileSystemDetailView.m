//
//  FileSystemDetailView.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FileSystemDetailView.h"
#import "FileSysDetailTableViewCell.h"
#import "FileSystemDetailSectionView.h"
#import "FileSystemNoDataView.h"
#import "FileManagerTool.h"

@interface FileSystemDetailView()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *_dataArray;
    NSMutableArray *_selectedArray;
}

@property (nonatomic, strong) FileSystemDetailSectionView *bottomView;

@property (nonatomic, strong) FileSystemNoDataView *noDataView;


@end

@implementation FileSystemDetailView

- (FileSystemNoDataView*)noDataView{
    if (!_noDataView) {
        _noDataView = [[FileSystemNoDataView alloc] initWithFrame:CGRectZero desc:@"文件夹无任何内容~"];
    }
    return _noDataView;
}

- (FileSystemDetailSectionView*)bottomView{
    if (!_bottomView) {
        _bottomView = [[FileSystemDetailSectionView alloc] init];
    }
    return _bottomView;
}

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsMultipleSelectionDuringEditing = YES;
        [_tableView registerNib:[UINib nibWithNibName:@"FileSysDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"detailCell"];
        _tableView.tableFooterView = [[UIView alloc] init];
        UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
        refresh.tintColor = [UIColor whiteColor];
        [refresh addTarget:self action:@selector(headerRefresh) forControlEvents:UIControlEventValueChanged];
        _tableView.refreshControl = refresh;
    }
    return _tableView;
}

#pragma mark - tableview header refresh
- (void)headerRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->_tableView.refreshControl endRefreshing];
    });
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    _selectedArray = [NSMutableArray array];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(50 + NavMustAdd));
    }];
    
    [self addSubview:self.tableView];
    _dataArray = [NSMutableArray array];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(_bottomView.mas_top);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FileSysDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    NSString *fileName = _dataArray[indexPath.row];
    NSString *filePath = [[DocumentsPath stringByAppendingPathComponent:self.currentDir] stringByAppendingPathComponent:fileName];
    
    cell.contentTitleLabel.text = fileName;
    
    //获取文件属性
    NSDictionary * fileInfo = [[FileManagerTool sharedManagerTool] fileInfomation:filePath];
    NSDate *date = fileInfo[@"NSFileCreationDate"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    cell.timeLabel.text = dateStr;
    
    //文件大小
    long long  byteSize = [fileInfo[NSFileSize] unsignedLongLongValue];
    CGFloat realSize = byteSize / (1024.0 * 1024.0);
    if (realSize > 1024) {
        cell.contentSizeLabel.text = [NSString stringWithFormat:@"大小：%.2fGB",realSize / 1024];
    }else if (realSize < 1){
        cell.contentSizeLabel.text = [NSString stringWithFormat:@"大小：%.2fkb",realSize * 1024];
    }else{
        cell.contentSizeLabel.text = [NSString stringWithFormat:@"大小：%.2fMB",realSize];
    }
    
    UIView *selectedBgView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBgView.backgroundColor = kTabBarBackgroundColor;
    cell.selectedBackgroundView = selectedBgView;
    cell.extensionLabel.text = [fileName pathExtension];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //非编辑状态下
    NSString *fileName = _dataArray[indexPath.row];
    
    if (!_tableView.isEditing) {
        [_selectedArray removeAllObjects];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSString *fileName = _dataArray[indexPath.row];
          
          if ([self.delegate respondsToSelector:@selector(didClickedFileWithFilePath:)]) {
              [self.delegate didClickedFileWithFilePath:fileName];
          }
        
        return;
    }
    
    //编辑状态下 记录所选索引或其他参数
    if (![_selectedArray containsObject:fileName]) {
        [_selectedArray addObject:fileName];
        
        //回调选择数据
        if ([self.delegate respondsToSelector:@selector(updateSelectedData:)]) {
            [self.delegate updateSelectedData:_selectedArray];
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *fileName = _dataArray[indexPath.row];
    [_selectedArray removeObject:fileName];
    
    //回调选择数据
    if ([self.delegate respondsToSelector:@selector(updateSelectedData:)]) {
        [self.delegate updateSelectedData:_selectedArray];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *fileName = _dataArray[indexPath.row];
    NSString *filePath = [[DocumentsPath stringByAppendingPathComponent:self.currentDir] stringByAppendingPathComponent:fileName];
    
    [[FileManagerTool sharedManagerTool] deleteFileAtFilePath:filePath];
        
    [_dataArray removeObjectAtIndex:indexPath.row];
    
    [tableView deleteRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];

}

- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)updateDetailView:(NSMutableArray *)dataArray{
    if (dataArray.count == 0) {
           [self addSubview:self.noDataView];
           [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.center.equalTo(self);
           }];
       }else{
           [UIView animateWithDuration:1.0 animations:^{
               self.noDataView.alpha = 0.0;
           } completion:^(BOOL finished) {
               [self.noDataView removeFromSuperview];
           }];
       }
    
    _dataArray = dataArray;
    [self.tableView reloadData];
}

@end
