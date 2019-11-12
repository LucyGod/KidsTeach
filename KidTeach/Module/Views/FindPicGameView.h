//
//  FindPicGameView.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 12/11/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol GameSuccessDelegate <NSObject>

- (void)didSuccessGame;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FindPicGameView : UIView

@property (nonatomic, weak) id <GameSuccessDelegate> delegate;

@property (nonatomic, copy) NSString *picName;

- (instancetype)initWithFrame:(CGRect)frame withPicName:(NSString *)picName;

@end

NS_ASSUME_NONNULL_END
