//
//  PayHelp.h
//  FeiHuaLing
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 lg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>


@interface PayHelp : NSObject

+(PayHelp*)sharePayHelp;

/**
*开始购买
 * productId 产品ID   
*/
-(void)applePayWithProductId:(NSString*)productId;
/**
 *恢复交易
 */
-(void)restorePurchase;

- (BOOL)isApplePay;

@end
