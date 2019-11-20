//
//  HomeViewController.m
//  LiveOfBeiJing
//
//  Created by Bingo on 2018/11/19.
//

#import "FourthViewController.h"
#import "PlayerViewController.h"

@interface FourthViewController ()
@end

@implementation FourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    PlayerViewController *palyVC = [[PlayerViewController alloc] init];
    palyVC.hidesBottomBarWhenPushed = YES;
    [palyVC playWithVideoUrl:@"https://v-cdn.zjol.com.cn/280443.mp4"];
    [self.navigationController presentViewController:palyVC animated:YES completion:^{
        
    }];
}
@end
