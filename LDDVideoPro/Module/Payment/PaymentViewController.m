//
//  PaymentViewController.m
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentContentView.h"
#import "PayHelp.h"

@interface PaymentViewController ()

@property (nonatomic,strong) PaymentContentView *contentView;

@end

@implementation PaymentViewController

- (PaymentContentView*)contentView{
    if (!_contentView) {
        _contentView = [[PaymentContentView alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
}

- (void)initSubViews{
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"tempBG"];
    topImageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.width.equalTo(@SCREEN_Width);
        make.height.equalTo(@(SCREEN_Width*0.7));
    }];
    
    //closeBtn
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
    closeBtn.adjustsImageWhenHighlighted = NO;
    [closeBtn addTarget:self action:@selector(dismissCurrentVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@23);
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(Status_H + 12);
    }];
    
    //reBuyBtn
    UIButton *reBuyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    reBuyBtn.alpha = 0.7;
    reBuyBtn.layer.cornerRadius = 15;
    reBuyBtn.layer.masksToBounds = YES;
    [reBuyBtn setBackgroundColor:[UIColor whiteColor]];
    [reBuyBtn setTitle:@"恢复购买" forState:UIControlStateNormal];
    [reBuyBtn addTarget:self action:@selector(reBuyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reBuyBtn];
    [reBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.width.equalTo(@100);
        make.right.equalTo(self.view).offset(-20);
        make.centerY.equalTo(closeBtn.mas_centerY);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"升级";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(closeBtn);
        make.centerY.equalTo(topImageView.mas_centerY);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"宝宝拼音识字";
    label2.textColor = [UIColor whiteColor];
    label2.font = [UIFont systemFontOfSize:30.0 weight:UIFontWeightSemibold];
    [self.view addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(label1);
        make.top.equalTo(label1.mas_bottom).offset(8);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"一次购买，终身使用！";
    label3.textColor = [UIColor whiteColor];
    [self.view addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.leading.equalTo(label2);
           make.top.equalTo(label2.mas_bottom).offset(8);
    }];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    buyButton.layer.cornerRadius = 4.0;
    buyButton.layer.masksToBounds = YES;
    [buyButton setBackgroundImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
    buyButton.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightMedium];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyButton setTitle:@"￥18.00购买专业版" forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@44);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20);
        } else {
            make.bottom.equalTo(self.view).offset(-16);
        }
    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(topImageView.mas_bottom).offset(70);
        make.height.equalTo(@230);
    }];
    
    [contentView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"适用于高级版";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19.0 weight:UIFontWeightSemibold];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.bottom.equalTo(contentView.mas_top).offset(-8);
    }];
    
//    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] init];
//    swipe.direction = UISwipeGestureRecognizerDirectionDown;
//    [swipe addTarget:self action:@selector(swipeAction:)];
//    [self.view addGestureRecognizer:swipe];
//
}

//- (void)swipeAction:(UISwipeGestureRecognizer*)swipe{
////    NSLog(@"%f",swipe.)
//}

- (void)dismissCurrentVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/// 购买
- (void)buyBtnAction{
    
}

/// 恢复购买
- (void)reBuyBtnAction{
    
}

@end
