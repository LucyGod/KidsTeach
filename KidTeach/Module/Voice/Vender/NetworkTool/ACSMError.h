//
//  ACSMError.h
//  FarmRecovery
//
//  Created by 董浩 on 2016/10/20.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACSMError : NSObject

/**
 *  error code
 */
@property (nonatomic, assign) NSInteger resCode;
/**
 *  error message
 */
@property (nonatomic, copy) NSString *resMsg;
@end
