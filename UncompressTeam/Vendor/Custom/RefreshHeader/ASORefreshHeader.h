

#import "MJRefreshStateHeader.h"

@interface ASORefreshHeader : MJRefreshStateHeader
/** 加载指示图片 */
@property (weak, nonatomic, readonly) UIImageView *arrowView;
/** loading 视图 的样式 */
@property (assign, nonatomic) UIActivityIndicatorViewStyle activityIndicatorViewStyle;
/* 是否需要适配异形屏(刘海屏)，用在无导航栏时下拉展示 */
@property (assign, nonatomic) BOOL fixHeteroScreen;
/* 是否没有导航栏 */
@property (assign, nonatomic) BOOL isNonNavBar;
@end
