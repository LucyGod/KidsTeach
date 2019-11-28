//
//  CollectionViewCell.h
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//


#import <UIKit/UIKit.h>

@class CellModel;

@interface CollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *nameLab;

@property (nonatomic, assign) BOOL isCell;//0:列表视图,1:网格视图

@property (nonatomic, assign) BOOL isEditing;//0:不在编辑状态,1:在编辑状态

@property (nonatomic, strong) CellModel *model;//cell中元素数据源

@end
