//
//  YSEVRefreshTableView.m
//  AutoCraftsmenClub
//
//  Created by 朗月 on 16/12/6.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "LYTRefreshTableView.h"
@interface LYTRefreshTableView()

@end
@implementation LYTRefreshTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    self=[super initWithFrame:frame style:style];
    
    if (self) {
    
       self.estimatedRowHeight=0;
       self.estimatedSectionHeaderHeight=0; self.estimatedSectionFooterHeight=0;
       self.showsVerticalScrollIndicator = NO;
//       self.separatorStyle=UITableViewCellSeparatorStyleNone;
       self.tableFooterView =[[UIView alloc] initWithFrame:CGRectZero];
       self.backgroundColor=ASOColorBackGround;

    }
    
    return self;
}
#pragma mark - 带上下拉刷新
-(void)lx_mine_settingRefresh{

    //下拉刷新
    MJRefreshGifHeader *header=[LYTRefreshTableView tableViewHeaderViewGifRefresh];
    self.mj_header =header ;
    
    header.refreshingBlock=^(){
    
        if (self.refreshUpdateBlock) {
            
             self.refreshUpdateBlock();
        }
       
    };
    
    MJRefreshAutoStateFooter *footer=[[MJRefreshAutoStateFooter alloc]init];
    self.mj_footer=footer;
    
    footer.refreshingBlock=^(){
        
        if (self.refreshDownloadBlock) {
            
            self.refreshDownloadBlock();
            
        }
    
    };
    
}
-(void)lx_mine_settingsUpdateRefersh{
    
    UIRefreshControl *refreshHeader = [[UIRefreshControl alloc] init];
    refreshHeader.tintColor = ASOColorTheme;
    [refreshHeader addTarget:self action:@selector(refreshHeaderAction) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshHeader;
  
    //下拉刷新
//    MJRefreshGifHeader *header=[YSEVRefreshTableView tableViewHeaderViewGifRefresh];
//    self.mj_header =header ;
//
//    header.refreshingBlock=^(){
//
//        if (self.refreshUpdateBlock) {
//
//            self.refreshUpdateBlock();
//        }
//
//    };
}

- (void)refreshHeaderAction{
    if (self.refreshUpdateBlock) {
 
        self.refreshUpdateBlock();
    }
}

-(void)lx_mine_settingDownloadRefersh{
    
    MJRefreshAutoStateFooter *footer=[[MJRefreshAutoStateFooter alloc]init];
    self.mj_footer=footer;
    
    footer.refreshingBlock=^(){
        
        if (self.refreshDownloadBlock) {
            
            self.refreshDownloadBlock();
            
        }
        
    };
    
}
-(void)lx_mine_enddingRefresh{

    [self.refreshControl endRefreshing];
    
    [self.mj_footer endRefreshing];
    [self.mj_header endRefreshing];
}
#pragma mark -上下拉刷新图标
+(MJRefreshGifHeader *)tableViewHeaderViewGifRefresh{
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:nil];
    return header;
    
}
#pragma mark -上下拉刷新图标
+(MJRefreshGifHeader *)tableViewNewHeaderViewGifRefresh{
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:nil];
    
    
    return header;
    
}
@end
