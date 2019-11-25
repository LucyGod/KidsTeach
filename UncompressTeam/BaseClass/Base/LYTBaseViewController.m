//
//  YSEVNLYNetworkViewController.m
//  cloudshang
//
//  Created by 高燕 on 2019/7/15.
//  Copyright © 2019 gaoyan. All rights reserved.
//

#import "LYTBaseViewController.h"
#import "LYTBaseNavigationController.h"
@interface LYTBaseViewController ()<UIScrollViewDelegate>

@end

@implementation LYTBaseViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return _StatusBarStyle;
}

//动态更新状态栏颜色
-(void)setStatusBarStyle:(UIStatusBarStyle)StatusBarStyle{
    
    
    _StatusBarStyle=StatusBarStyle;
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [UIViewController attemptRotationToDeviceOrientation];
//    if (@available(iOS 13.0, *)) {
//        self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
//    } else {
        // Fallback on earlier versions
        self.view.backgroundColor = ASOColorBackGround;
 //   }
    self.StatusBarStyle=UIStatusBarStyleLightContent;
//    
//    //添加背景图片
//    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"baseBGImg"]];
//    bgImageView.frame = self.view.bounds;
//    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:bgImageView];
//
}
-(void)lx_mine_createNavBottomBlackLineView{
    
    UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0,0, kScreenWidth, 1)];
    lineView.backgroundColor=ASOColorTheme;
    [self.view addSubview:lineView];
}
- (void)presentBackButton:(NSString *)imgname{
    
    if (!imgname){
        imgname=@"back_icon";
    }
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    _leftNavButton=btn;
    btn.tag=0;
    btn.backgroundColor=[UIColor clearColor];
    [btn setImage:[UIImage imageWithContentsOfFile:bundlePath(imgname)] forState:UIControlStateNormal];
    btn.frame=CGRectMake(0, 10, 9, 19);
    [btn addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
//导航栏标题
-(void)showNavigationTitle:(NSString *)titleName{
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, NAVIGATION_BAR_HEIGHT)];
    titleLabel.text = titleName;
    titleLabel.font =[UIFont boldSystemFontOfSize:18];
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
}
-(void)showNavBarTitle:(NSString *)titleName withColor:(UIColor *)titleColor{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, NAVIGATION_BAR_HEIGHT)];
    titleLabel.text = titleName;
    titleLabel.font =[UIFont boldSystemFontOfSize:18];
    titleLabel.textColor =titleColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;

    self.navigationItem.titleView = titleLabel;
}
//导航栏自定义view
-(void)showNavigationView:(UIView *)view{
    self.navigationItem.titleView = view;
}
// 添加导航按钮==》（带文字按钮）
- (void)showNavItemTitle:(NSString *)txtname left:(BOOL)isLeft{
    
    if (isLeft){

        CGSize size=[txtname lyFont:lyFont(15) constrainedSize:CGSizeZero];

        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=0;
        _leftNavButton=btn;
        btn.backgroundColor=[UIColor clearColor];
        btn.frame=CGRectMake(0, 0, size.width+15, 44);
        [btn setTitle:txtname forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn.titleLabel setFont:lyFont(14)];

        [btn addTarget:self action:@selector(popFromCurrent:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }else{
        CGSize size=[txtname lyFont:lyFont(15) constrainedSize:CGSizeZero];

        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightNavButton=btn;
        btn.tag=1;
        btn.backgroundColor=[UIColor clearColor];
        btn.frame=CGRectMake(0, 0, size.width+15, 44);
        [btn setTitle:txtname forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont boldSystemFontOfSize:15];
        btn.userInteractionEnabled = YES;
        btn.titleEdgeInsets=UIEdgeInsetsMake(0,13, 0, 0);
        [btn setShowsTouchWhenHighlighted:YES];
        [btn addTarget:self action:@selector(popFromCurrent:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

        if(stringIsNil(txtname)){
            btn.userInteractionEnabled = NO;
        }
    }
    
}
- (void)showNavItemTitleColor:(UIColor *)color left:(BOOL)isLeft{

    if (isLeft) {

        [_leftNavButton setTitleColor:color forState:UIControlStateNormal];
    }else{

        [_rightNavButton setTitleColor:color forState:UIControlStateNormal];
    }

}
// 添加导航按钮==》（带图片按钮）
- (void)showNavItemImg:(NSString *)imgname left:(BOOL)isLeft{

    if (isLeft){

        if (!imgname){
            imgname=@"back_icon";
        }
        if (!_leftNavButton){
            _leftNavButton=[UIButton buttonWithType:UIButtonTypeCustom];
        }
        _leftNavButton.tag=0;
        _leftNavButton.backgroundColor=[UIColor clearColor];
        _leftNavButton.frame=CGRectMake(0, 0, 40, 40);
        [_leftNavButton addTarget:self action:@selector(popFromCurrent:) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.navigationController){

            UIBarButtonItem *leftItem=[[UIBarButtonItem alloc] initWithCustomView:_leftNavButton];

            UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
            
            negativeSpacer.width=-15;
//            self.navigationItem.leftBarButtonItems =@[negativeSpacer,leftItem];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(popFromCurrent:)];

        }else{
            if (!imgname){
                imgname=@"back_icon";
            }
            _leftNavButton.frame=CGRectMake(0,0,40, 40);
            [_leftNavButton setBackgroundColor:[UIColor clearColor]];
            if (!_leftNavButton.superview){
                [self.view addSubview:_leftNavButton];
            }
        }

        [_leftNavButton setImage:kImage(imgname) forState:UIControlStateNormal];

    }else{

        if (!_rightNavButton){
            _rightNavButton=[UIButton buttonWithType:UIButtonTypeCustom];
        }
        _rightNavButton.tag=1;
        _rightNavButton.backgroundColor=CLEARCOLOR;

        _rightNavButton.frame=CGRectMake(0, 0,40, 40);
        [_rightNavButton addTarget:self action:@selector(popFromCurrent:) forControlEvents:UIControlEventTouchUpInside];
        [_rightNavButton setImage:kImage(imgname) forState:UIControlStateNormal];


        UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithCustomView:_rightNavButton];
        UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        negativeSpacer.width=-15;
        
        self.navigationItem.rightBarButtonItems =@[negativeSpacer,rightItem];
    }

}
// 添加导航按钮==》（带view按钮）
- (void)showNavItemView:(UIView *)viw left:(BOOL)isLeft{

    UIBarButtonItem *tItem=[[UIBarButtonItem alloc] initWithCustomView:viw];
    UIBarButtonItem *negativeSpacer=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    negativeSpacer.width=-15;
    
    if (isLeft){
        if (self.navigationController){
            self.navigationItem.leftBarButtonItems=@[negativeSpacer,tItem];
        }
    }else{

        self.navigationItem.rightBarButtonItems =@[negativeSpacer,tItem];;
    }
    
}
- (void)showNavTitleImage:(NSString *)imageName{

    UIImageView *imangev = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 69/2, 28/2)];
    imangev.userInteractionEnabled=YES;
    imangev.image=kImage(imageName);
    self.navigationItem.titleView = imangev;
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(middleTitleViewClickGesture:)];

    [imangev addGestureRecognizer:tapGesture];
}
-(void)middleTitleViewClickGesture:(UITapGestureRecognizer *)gesture{

    
}
// 导航上按钮点击事件
- (void)popFromCurrent:(UIButton *)btn{

    if (btn.tag==0){
        [self leftBtnClicked];

    }else if (btn.tag==1){
        [self rightButtonClicked:btn];
    }else{
        [self btnFun:btn];
    }
}
//导航上左边返回按钮点击事件
- (void)leftBtnClicked{

    LYTBaseNavigationController *nav = (LYTBaseNavigationController *)self.navigationController;
    NSArray *arrNav = nav.viewControllers;
    if (arrNav.count <= 2) {
    }if (self.navigationController){

        [self.navigationController popViewControllerAnimated:YES];
    }else [self dismissViewControllerAnimated:YES completion:^{}];
    
}
//导航上右边返回按钮点击事件
- (void)rightButtonClicked:(UIButton *)btn{

}
//导航上其他按钮点击事件
- (void)btnFun:(UIButton *)btn{

}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    LYTBaseNavigationController *nav = (LYTBaseNavigationController *)self.navigationController;
    nav.navigationBar.tintColor = [UIColor whiteColor];
    NSArray *arrNav = nav.viewControllers;
    if (arrNav.count > 1){
        [self showNavItemImg:nil left:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
