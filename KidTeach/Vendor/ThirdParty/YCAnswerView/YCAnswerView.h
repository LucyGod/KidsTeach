//
//  YCAnswerView.h
//  计算器
//
//  Created by 王月超 on 2018/2/7.
//  Copyright © 2018年 wyc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^YCAnswerViewBlock)(void);
@interface YCAnswerView : UIView
@property (nonatomic,copy)YCAnswerViewBlock resultBlock;
@end
