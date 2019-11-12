//
//  ASODetailContentTopView.h
//  KidTeach
//
//  Created by LonelyTown on 2019/11/11.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DetailContentTopViewDelegate <NSObject>

- (void)didSelectdTopViewItemAtIndexpath:(NSIndexPath*)indexpath param:(NSDictionary*)paramDic;

@end

@interface ASODetailContentTopView : UIView

@property (nonatomic, weak) id<DetailContentTopViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame contentType:(NSString*)type;

- (void)updateTopView:(NSArray*)dataArray;

@end

NS_ASSUME_NONNULL_END
