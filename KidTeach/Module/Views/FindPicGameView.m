//
//  FindPicGameView.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 12/11/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "FindPicGameView.h"
@interface FindPicGameView ()

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSMutableArray *nameArray;
@property (nonatomic, assign) NSInteger picNumber;

@end

@implementation FindPicGameView

- (instancetype)initWithFrame:(CGRect)frame withPicName:(NSString *)picName {
    if (self = [super initWithFrame:frame]) {
        self.picName = picName;
        [self congfigDataArray];
        CGFloat space = 3;
        CGFloat w = (frame.size.width - 3 * space)/4;
        CGFloat yy = (frame.size.height - w*2 - space)/2;
        for (NSInteger i = 0; i < 8; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"fanmian_sz02"] forState:UIControlStateNormal];
            CGFloat x = (i%4)*(space + w);
            CGFloat y = (i/4)*(space + w) + yy;
            btn.frame = CGRectMake(x, y, w, w);
            btn.tag = 100 + i;
            [btn addTarget:self action:@selector(findButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.userInteractionEnabled = NO;
            [self addSubview:btn];
        }
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"star_sz02"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(beginClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(170, 70));
        }];
    }
    return self;
}

- (void)congfigDataArray {
    int i = arc4random() % 2;
    if (i == 1) {
        self.picNumber = 4;
    } else {
        self.picNumber = 5;
    }
    [self.nameArray removeObject:self.picName];
    for (NSInteger i = 0; i< 8; i++) {
        if (i < self.picNumber) {
            [self.dataArray addObject:self.picName];
        } else {
            int n = arc4random() % [self.nameArray count];
            NSString *name = self.nameArray[n];
            [self.dataArray addObject:name];
        }
    }
    [self randomArr];
}

/// 打乱数组顺序
- (void)randomArr {
    NSArray *arr = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(NSString *str1, NSString *str2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [str1 compare:str2];
        } else {
            return [str2 compare:str1];
        }
    }];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:arr];
}

- (void)findButtonClick:(UIButton *)btn {
    NSInteger i = btn.tag - 100;
    NSString *name = [self.dataArray objectAtIndex:i];
    [self showImageWithTag:i isBg:NO];
    if ([name isEqualToString:self.picName]) {
        btn.userInteractionEnabled = NO;
        self.picNumber --;
        if (self.picNumber == 0) {
            
            if ([self.delegate respondsToSelector:@selector(didSuccessGame)]) {
                [self.delegate didSuccessGame];
            }
        }
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)    (2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [self showImageWithTag:i isBg:YES];
        });
    }
}

- (void)beginClick:(UIButton *)btn {
    btn.hidden = YES;
    for (NSInteger i = 0; i < 8; i++) {
        [self showImageWithTag:i isBg:NO];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)    (2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      for (NSInteger i = 0; i < 8; i++) {
          [self showImageWithTag:i isBg:YES];
          UIButton *button = (UIButton *)[self viewWithTag:100 +i];
          button.userInteractionEnabled = YES;
      }
    });
}

- (void)showImageWithTag:(NSInteger)i isBg:(BOOL)isBg {
    UIButton *button = (UIButton *)[self viewWithTag:100 +i];
    if (isBg) {
        [UIView transitionWithView:button duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{

            [button setBackgroundImage:[UIImage imageNamed:@"fanmian_sz02"] forState:UIControlStateNormal];

        }completion:^(BOOL finished) {

        }];
    } else {
        [UIView transitionWithView:button duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            [button setBackgroundImage:[UIImage imageNamed:self.dataArray[i]] forState:UIControlStateNormal];
            
        }completion:^(BOOL finished) {

        }];
    }
    
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [NSMutableArray arrayWithArray:@[@"兔子", @"马",@"羊",@"驴",@"老鼠", @"猫",@"老虎",@"狮子",@"熊猫", @"大象",@"熊",@"长颈鹿",@"乌龟", @"妈妈",@"爷爷",@"爸爸",@"外婆", @"伯父",@"舅妈",@"叔叔",@"婶婶", @"姑夫",@"姐姐",@"哥哥",@"弟弟", @"妹妹",@"香菇",@"洋葱",@"木耳", @"冬瓜",@"大白菜",@"辣椒",@"黄瓜", @"萝卜",@"苦瓜",@"南瓜",@"桃子", @"苹果",@"香蕉",@"梨子",@"西瓜", @"橘子",@"草莓",@"杨桃"]];
    }
    return _nameArray;
}

@end
