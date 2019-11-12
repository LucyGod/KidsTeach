//
//  FAPBaseTableViewCell.h
//  KidTeach
//
//  Created by MAC on 22/10/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FAPBaseTableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *bottomLine;

- (void)configUI;

//赋值的方法
- (void)setDataWithSourceData:(id)model;

- (void)showBottomLine;

- (void)hiddenBottomLine;

+(CGFloat)getCellHeightWithString:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
