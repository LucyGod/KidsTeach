//
//  ASOContentViewController.h
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASOContentViewController : UIViewController

@property (nonatomic, strong) NSString *typeName;
@property (weak, nonatomic) IBOutlet UIButton *nameVoiceButton;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UIButton *contentVoiceButton;

@property (weak, nonatomic) IBOutlet UIImageView *kuangImageView;

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (weak, nonatomic) IBOutlet UILabel *contentPingYinLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentNameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *contentBGView;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


- (IBAction)backButtonAction:(id)sender;


/// 点击名字发音
- (IBAction)voiceButtonAction:(id)sender;


/// 点击下一个
/// @param sender button
- (IBAction)tapNextButtonAction:(id)sender;


/// 点击内容发声
/// @param sender button
- (IBAction)contentVoiceButtonAction:(id)sender;



@end

NS_ASSUME_NONNULL_END
