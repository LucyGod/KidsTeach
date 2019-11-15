//
//  CircleViewController.m
//  LiveOfBeiJing
//
//  Created by liuyongfei on 2018/11/19.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[FirstViewController new] animated:YES];
}


@end
