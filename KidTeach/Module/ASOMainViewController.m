//
//  ASOMainViewController.m
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "ASOMainViewController.h"
#import "ASOContentViewController.h"
#import "MusicHomeViewController.h"
@interface ASOMainViewController ()

@end

@implementation ASOMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (IBAction)menuButtonAction:(UIButton *)sender {
    NSInteger tag = sender.tag;
    NSLog(@"%ld",tag);
    ASOContentViewController *contentVC = [[ASOContentViewController alloc] init];
    switch (tag) {
        case 0:
            //认识动物
            contentVC.typeName = @"动物";
            break;
        case 1:
            //认识水果
            contentVC.typeName = @"水果";
            break;
        case 2:
            //认识蔬菜
            contentVC.typeName = @"蔬菜";
            break;
        case 3:
            //家庭成员
            contentVC.typeName = @"家庭成员";
            break;
        case 4:
            //基础识字
        {
            MusicHomeViewController *music = [[MusicHomeViewController alloc] init];
            [self.navigationController pushViewController:music animated:YES];
            return ;
        }
        default:
            break;
    }
    
    [self.navigationController pushViewController:contentVC animated:YES];
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
