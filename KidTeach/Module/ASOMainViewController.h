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
@property (weak, nonatomic) IBOutlet UIButton *animalButton;
@property (weak, nonatomic) IBOutlet UIButton *fruitButton;
@property (weak, nonatomic) IBOutlet UIButton *vagetableButton;
@property (weak, nonatomic) IBOutlet UIButton *peopleButton;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;


@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


- (IBAction)menuButtonAction:(UIButton *)sender;

- (IBAction)settingAction:(id)sender;


@end

NS_ASSUME_NONNULL_END
