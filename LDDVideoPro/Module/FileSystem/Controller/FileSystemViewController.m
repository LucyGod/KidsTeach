//
//  CircleViewController.m
//  LiveOfBeiJing
//
//  Created by liuyongfei on 2018/11/19.
//

#import "FileSystemViewController.h"
#import "PaymentViewController.h"
#import "FIleSystemMainView.h"

@interface FileSystemViewController ()<FileMainDelegate>

@property (nonatomic,strong) FIleSystemMainView *fileSysView;

@end

@implementation FileSystemViewController

- (FIleSystemMainView*)fileSysView{
    if (!_fileSysView) {
        _fileSysView = [[FIleSystemMainView alloc] initWithFrame:CGRectZero];
        _fileSysView.delegate = self;
    }
    return _fileSysView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"购买" style:UIBarButtonItemStylePlain target:self action:@selector(buyAction)];
    
    [self.view addSubview:self.fileSysView];
    [self.fileSysView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - FileMainDelegate
- (void)didSelecteFileItemAtIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"%ld",indexPath.row]];
}

- (void)buyAction{
    PaymentViewController *paymentVC = [[PaymentViewController alloc] init];
    paymentVC.modalPresentationStyle = 0;
    [self presentViewController:paymentVC animated:YES completion:nil];
}

@end
