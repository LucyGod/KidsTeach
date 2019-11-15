//
//  YSEVRefreshTableView.h
//  AutoCraftsmenClub
//
//  Created by 朗月 on 16/12/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefreshGifHeader.h"

typedef void(^RefreshHeaderTableViewBlock)(void);
typedef void(^RefreshFooterTableViewBlock)(void);

@interface LYTRefreshTableView : UITableView
@property(nonatomic,copy)RefreshHeaderTableViewBlock refreshUpdateBlock;
@property(nonatomic,copy)RefreshFooterTableViewBlock refreshDownloadBlock;

-(void)lx_mine_settingsUpdateRefersh;
-(void)lx_mine_settingDownloadRefersh;
-(void)lx_mine_settingRefresh;
-(void)lx_mine_enddingRefresh;
+(MJRefreshGifHeader *)tableViewHeaderViewGifRefresh;

@end
