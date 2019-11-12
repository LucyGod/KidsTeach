//
//  FAPBaseViewController.m
//  KidTeach
//
//  Created by Mac on 2019/5/9.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPBaseViewController.h"
#import <objc/message.h>
@interface FAPBaseViewController ()

/** 返回按钮 */
@property (strong, nonatomic) UIButton *___backBtn;

/**  返回事件执行者 */
@property (weak, nonatomic) id ___backTarget;

/**  返回事件 */
@property (assign, nonatomic) SEL ___backAction;

@end

@implementation FAPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = ASOColorBackGround;
}

- (UIBarButtonItem *)rt_customBackItemWithTarget:(id)target action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.___backBtn];
    
    self.___backTarget = target;
    
    self.___backAction = action;
    
    return item;
}

#pragma mark - 私有方法 --

/**
 返回按钮事件

 @param backBtn 返回按钮
 */
- (void)p_backBtnAction:(UIButton *)backBtn {
    
    if (self.shouldBackBlock) {
        
        BOOL isCanBack = self.shouldBackBlock(backBtn);
        
        if (isCanBack && self.___backTarget && [self.___backTarget respondsToSelector:self.___backAction]) {
            // 可返回
            ((void(*)(id,SEL,UIButton *))objc_msgSend)(self.___backTarget,self.___backAction,self.___backBtn);
        }
        
    }else {
        // 可返回
        if (self.___backTarget && [self.___backTarget respondsToSelector:self.___backAction]) {
            ((void(*)(id,SEL,UIButton *))objc_msgSend)(self.___backTarget,self.___backAction,self.___backBtn);
        }
    }
}

#pragma mark - 懒加载 --

- (UIButton *)___backBtn {
    if (!____backBtn) {
        ____backBtn = [[UIButton alloc] init];
        [____backBtn setImage:[UIImage imageNamed:@"bt_navigation_back_nor"] forState:UIControlStateNormal];
        [____backBtn addTarget:self action:@selector(p_backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return ____backBtn;
}

@end
