//
//  CellModel.m
//  UncompressTeam
//
//  Created by mac on 2019/11/26.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel

- (void)setData:(NSString *)iconName name:(NSString *)name createTime:(NSString *)createTime size:(NSString *)size {
    self.iconName = iconName;
    self.name = name;
    self.createTime = createTime;
    self.size = size;
}

@end
