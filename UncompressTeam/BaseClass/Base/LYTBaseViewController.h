//
//  YSEVNLYNetworkViewController.h
//  cloudshang
//
//  Created by 高燕 on 2019/7/15.
//  Copyright © 2019 gaoyan. All rights reserved.
//

@interface LYTBaseViewController : UIViewController
{
    UIButton *_leftNavButton;    // 左边按钮
    UIButton *_rightNavButton;   // 右边按钮
    UIView   *_ItemLeftView;
    UIView   *_ItemRightView;
}
// 导航按钮
- (void)showNavItemImg:(NSString *)imgname left:(BOOL)isLeft;
- (void)showNavItemTitle:(NSString *)txtname left:(BOOL)isLeft;
- (void)showNavItemView:(UIView *)viw left:(BOOL)isLeft;// 添加导航按钮==》（带view按钮）
- (void)showNavTitleImage:(NSString *)imageName;
- (void)presentBackButton:(NSString *)imgname;
- (void)showNavigationView:(UIView *)view;
- (void)showNavigationTitle:(NSString *)titleName;
- (void)showNavItemTitleColor:(UIColor *)color left:(BOOL)isLeft;
- (void)showNavBarTitle:(NSString *)titleName withColor:(UIColor *)titleColor;

// 导航按钮点击事件
- (void)leftBtnClicked;
- (void)rightButtonClicked:(UIButton *)btn;
- (void)btnFun:(UIButton *)btn;
- (void)middleTitleViewClickGesture:(UITapGestureRecognizer *)gesture;

-(void)lx_mine_createNavBottomBlackLineView;

/**
 *  修改状态栏颜色
 */
@property (nonatomic, assign) UIStatusBarStyle StatusBarStyle;
/**
 是否隐藏导航栏
 */
@property (nonatomic, assign) BOOL lx_mine_isHidenNaviBar;


@end
