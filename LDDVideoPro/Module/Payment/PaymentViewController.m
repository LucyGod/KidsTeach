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
#import "PayMentTableViewCell.h"
#import "PaymentNormalTableViewCell.h"


@interface PaymentViewController ()<UITableViewDelegate,UITableViewDataSource,PaymentCellDelegate>

@property (nonatomic,strong) PaymentContentView *contentView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *mainView;

@property (nonatomic, strong) UIView *footerView;

@end

@implementation PaymentViewController

- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = self.mainView;
        _tableView.tableFooterView = self.footerView;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = 200;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"PayMentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PaymentNormalTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell1"];
    }
    return _tableView;
}

- (PaymentContentView*)contentView{
    if (!_contentView) {
        _contentView = [[PaymentContentView alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        _closeBtn.adjustsImageWhenHighlighted = NO;
        [_closeBtn addTarget:self action:@selector(dismissCurrentVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth*0.7 + 300)];
    _mainView.backgroundColor = [UIColor clearColor];
    _mainView.userInteractionEnabled = YES;
    
    self.footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 180)];
    _footerView.backgroundColor = [UIColor clearColor];
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightThin];
    contentLabel.textColor = [UIColor lightGrayColor];
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@"购买确认时，付款将记入iTunes帐户。除非在当前期间结束前至少24小时关闭自动续订，否则订阅将自动续订。在本期结束前24小时内，账户将收取续期费用，并确定续期费用。订阅可以由用户管理，购买后转到用户帐户设置可以关闭自动续订。如果提供免费试用期的任何未使用部分，则当用户购买该出版物的订阅（如适用）时，将被没收。订阅可以由用户管理，购买后转到用户的帐户设置可以关闭自动续订您可以通过以下网址取消订阅：https://support.apple.com/en-us/HT202039"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3.0; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentJustified; //设置两端对齐显示
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(attributedStr.length - 40, 40)];
    
    contentLabel.attributedText = attributedStr;
    contentLabel.textAlignment = NSTextAlignmentLeft;
    [_footerView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_footerView);
        make.left.equalTo(_footerView).offset(12);
        make.right.equalTo(_footerView).offset(-12);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(-Status_H);
    }];
    
    [self initSubViews];
    
    [self configContentView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        PaymentNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PaymentNormalTableViewCell" owner:self options:nil] firstObject];
        }
        return cell;
    }else{
        PayMentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.delegate = self;
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PayMentTableViewCell" owner:self options:nil] firstObject];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 50;
    }
    return 200;
}

- (void)buyButtonActionHandler:(NSInteger)tag{
    
    NSString *proID = @"";
    switch (tag) {
        case 0:
            //单月
            proID = @"com.huangguashipin.6";
            break;
            
        case 1:
            //包季
            proID = @"com.huangguashipin.58";
            break;
            
        case 2:
            //包年
            proID = @"com.huangguashipin.15";
            break;
            
        default:
            break;
    }
    
    if ([[PayHelp sharePayHelp] isApplePay]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已购买过专业版，无需重复购买。" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [[PayHelp sharePayHelp] applePayWithProductId:proID];
}

- (void)initSubViews{
    
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.image = [UIImage imageNamed:@"tempBG"];
    topImageView.contentMode = UIViewContentModeScaleToFill;
    [self.mainView addSubview:topImageView];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.mainView);
        make.width.equalTo(@SCREEN_Width);
        make.height.equalTo(@(SCREEN_Width*0.7));
    }];
    
    //closeBtn
    [self.mainView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@23);
        make.left.equalTo(self.mainView).offset(20);
        make.top.equalTo(self.mainView).offset(Status_H + 12);
    }];
    
    //reBuyBtn
    UIButton *reBuyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    reBuyBtn.alpha = 0.7;
    reBuyBtn.layer.cornerRadius = 15;
    reBuyBtn.layer.masksToBounds = YES;
    [reBuyBtn setBackgroundColor:[UIColor whiteColor]];
    [reBuyBtn setTitle:@"恢复购买" forState:UIControlStateNormal];
    [reBuyBtn addTarget:self action:@selector(reBuyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:reBuyBtn];
    [reBuyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.width.equalTo(@100);
        make.right.equalTo(self.mainView).offset(-20);
        make.centerY.equalTo(self.closeBtn.mas_centerY);
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"升级";
    label1.textColor = [UIColor whiteColor];
    label1.font = [UIFont systemFontOfSize:14.0];
    [self.mainView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.closeBtn);
        make.centerY.equalTo(topImageView.mas_centerY);
    }];
    
    UIImageView *label2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"paymentTitle"]];
    [self.mainView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(label1);
        make.top.equalTo(label1.mas_bottom).offset(8);
    }];
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.text = @"专业版更懂你，随心畅用！";
        label3.textColor = [UIColor blackColor];
    label3.font = [UIFont systemFontOfSize:12.0];
    [self.mainView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(label2);
        make.top.equalTo(label2.mas_bottom).offset(12);
    }];
    
    //    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //    buyButton.layer.cornerRadius = 4.0;
    //    buyButton.layer.masksToBounds = YES;
    //    [buyButton setBackgroundImage:[UIImage imageNamed:@"paymentBtn"] forState:UIControlStateNormal];
    //    buyButton.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightMedium];
    //    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [buyButton setTitle:@"￥6.0/月" forState:UIControlStateNormal];
    //    [buyButton addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.mainView addSubview:buyButton];
    //    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
    ////        make.left.equalTo(self.view).offset(20);
    ////        make.right.equalTo(self.view).offset(-20);
    //        make.height.equalTo(@44);
    //        make.width.equalTo(@80);
    //        if (@available(iOS 11.0, *)) {
    //            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-20);
    //        } else {
    //            make.bottom.equalTo(self.view).offset(-16);
    //        }
    //    }];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor clearColor];
    contentView.userInteractionEnabled = YES;
    [self.mainView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.mainView);
        make.top.equalTo(topImageView.mas_bottom).offset(70);
        make.height.equalTo(@230);
    }];
    
    [contentView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(contentView);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"适用于专业版";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:19.0 weight:UIFontWeightSemibold];
    [self.mainView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.right.equalTo(self.view).offset(-12);
        make.bottom.equalTo(contentView.mas_top).offset(-8);
    }];
}

- (void)dismissCurrentVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)configContentView{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"settingConfig" ofType:@"json"];
    NSData *dataStock = [NSData dataWithContentsOfFile:path];
    NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:dataStock options:0 error:nil];
    
    [self.contentView updateContentView:dataArr];
}


/// 购买
- (void)buyBtnAction{
    if ([[PayHelp sharePayHelp] isApplePay]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已购买过专业版，无需重复购买。" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    [[PayHelp sharePayHelp] applePayWithProductId:@""];
}

/// 恢复购买
- (void)reBuyBtnAction{
    [[PayHelp sharePayHelp]restorePurchase];
}

@end
