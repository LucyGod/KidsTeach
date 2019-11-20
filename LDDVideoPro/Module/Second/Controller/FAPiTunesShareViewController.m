//
//  FAPiTunesShareViewController.m
//  LDDVideoPro
//
//  Created by MAC on 18/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "FAPiTunesShareViewController.h"

@interface FAPiTunesShareViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation FAPiTunesShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"iTunes传输";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = @"此功能可将电脑里的图片/gif/视频通过分享iTunes文件导入到应用程序。";
    self.contentLabel.textColor = [UIColor whiteColor];
    self.contentLabel.text = @"1.将设备连接到电脑，然后在电脑上打开iTunes。\n2.选择应用程序菜单，然后往下滑到iTunes文件共享。\n3.在iTunes文件共享，选择应用程序。\n4.拖放图片/gif/视频文件或使用添加按钮而添加文件。";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
