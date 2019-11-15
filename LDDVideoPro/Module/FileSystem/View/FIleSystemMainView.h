//
//  FIleSystemMainView.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/15.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FileMainDelegate <NSObject>

- (void)didSelecteFileItemAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface FIleSystemMainView : UIView

@property (nonatomic,weak) id<FileMainDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
