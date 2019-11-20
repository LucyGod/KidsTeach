//
//  FileSystemNoDataView.h
//  LDDVideoPro
//
//  Created by LonelyTown on 2019/11/18.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileSystemNoDataView : UIView

- (instancetype)initWithFrame:(CGRect)frame desc:(NSString*)desc;

- (instancetype)initWithFrame:(CGRect)frame desc:(NSString*)desc imageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
