//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface FileCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *selectedArr;

@property (nonatomic, assign) NSInteger selectedNum;

@property (nonatomic, assign) BOOL isEditing;

@property (nonatomic, assign) BOOL isCell;//0:列表视图,1:网格视图

@property (nonatomic, strong) UIDocumentInteractionController *documentVC;

@property (nonatomic, strong) NSString *filePath;


- (void)initFilePath: (NSString*)path;

/**
 *    @brief     排序
 *    @param     selectedSortType 选择的排序方式(1:名称 2:大小 3:日期 4:类型)
 *    @param     isDesc 是否降序
 *    @param     isDirectoryFirst 是否目录优先
 */

- (void)sortByTypes:(NSInteger)selectedSortType isDesc:(BOOL)isDesc isDirectoryFirst:(BOOL)isDirectoryFirst;
- (void)reloadData;

@end
