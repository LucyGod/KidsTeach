//
//  ASOMainViewController.h
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASOMainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


- (IBAction)menuButtonAction:(UIButton *)sender;

- (IBAction)settingAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
