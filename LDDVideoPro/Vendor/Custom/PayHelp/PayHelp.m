//
//  PayHelp.m
//  FeiHuaLing
//
//  Created by mdyuwen on 2018/4/19.
//  Copyright © 2018年 lg. All rights reserved.
//

#import "PayHelp.h"
@interface PayHelp ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
@end

@implementation PayHelp

+(PayHelp*)sharePayHelp{
    static PayHelp * help=nil;
    if(help==nil){
        help=[[PayHelp alloc]init];
    }
    return help;
}
-(id)init{
    self = [super init];
    if(self){
        // 4.设置支付服务-APP内购
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}
-(BOOL)isApplePay
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isPay"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
  
}
#pragma mark 购买内购
-(void)applePayWithProductId:(NSString*)productId{
    
    //判断app是否允许apple支付
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"yes");// 6.请求苹果后台商品
        //注释的是
//        [Help showHUDWithTitle:SKPLocalizedString(@"Purchasing...")];
//        [Help disableRightSlipBack];//关闭右滑动返回手势
        [self getRequestAppleProductWithProductId:productId];
        [SVProgressHUD show];
    }
    else {
        NSLog(@"not");
        
        /** 手机不支持支付 在这里做提示*/
//        [Help hideHUDWithTitle:SKPLocalizedString(@"Your phone is not open for in-app purchases")];
        //开启右滑动返回手势
    }
}

//请求苹果商品
- (void)getRequestAppleProductWithProductId:(NSString *)productId{
    // 7.这里的com.czchat.CZChat01就对应着苹果后台的商品ID,他们是通过这个ID进行联系的。
    NSArray *product = [[NSArray alloc] initWithObjects:productId,nil];
    NSSet *nsset = [NSSet setWithArray:product];
    // 8.初始化请求
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    // 9.开始请求
    [request start];
    
}
// 10.接收到产品的返回信息,然后用返回的商品信息进行发起购买请求
- (void) productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *product = response.products;
    //如果服务器没有产品
    if([product count] == 0){
        NSLog(@"nothing");
        //获取商品信息失败
        
//        [Help hideHUDWithTitle:SKPLocalizedString(@"The purchase failed, please try again")];
        //开启右滑动返回手势
        return;
    }
    SKProduct *requestProduct = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        // 11.如果后台消费条目的ID与我这里需要请求的一样（用于确保订单的正确性）
        requestProduct = pro;
    }
    // 12.发送购买请求
    SKPayment *payment = [SKPayment paymentWithProduct:requestProduct];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    
}
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"error:%@", error);
    [SVProgressHUD showErrorWithStatus:@"购买失败，请重试。"];
//    [Help hideHUDWithTitle:SKPLocalizedString(@"The purchase failed, please try again")];
    //开启右滑动返回手势
}
//反馈请求的产品信息结束后
- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"信息反馈结束");
}


#pragma mark 恢复内购
-(void)restorePurchase{
//    [Help showHUDWithTitle:SKPLocalizedString(@"Restoring...")];
    [SVProgressHUD show];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];//回调已经购买过的项目
}
//获取已经购买过的内购项目
- (void) paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    NSLog(@"received restored transactions: %ld", queue.transactions.count);
    if (queue.transactions.count==0) {
        //提示用户恢复失败
//        [Help hideHUDWithTitle:SKPLocalizedString(@"The Restore failed, please try again")];
    }
    for (SKPaymentTransaction *transaction in queue.transactions){
        NSString *productID = transaction.payment.productIdentifier;
        NSLog(@"%@",productID);
        NSLog(@"%ld",(long)transaction.transactionState);
        if (transaction.transactionState==SKPaymentTransactionStateRestored) {
            
        }
    }
}
//恢复内购失败调用-比如用户没有登录apple id 手动取消恢复
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error{
//    [Help hideHUDWithTitle:SKPLocalizedString(@"The Restore failed, please try again")];
    [SVProgressHUD dismiss];
}
#pragma mark 购买和恢复都会回调
// 13.监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    
    for(SKPaymentTransaction *tran in transaction){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStatePurchased:
                //购买成功-第一次购买和恢复已购项目都会回调这个
//                [Help hideHUDWithTitle:SKPLocalizedString(@"Purchase success")];
                [self addUseCount];//-为用户添加权益
                [SVProgressHUD showSuccessWithStatus:@"购买成功"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isPay"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            case SKPaymentTransactionStateRestored:
                //购买已经购买过的商品的商品会回调这个
//                [Help hideHUDWithTitle:SKPLocalizedString(@"Restore success")];
                [SVProgressHUD showSuccessWithStatus:@"恢复购买成功"];
                [self addUseCount];//用户已经购买过-为用户恢复权益
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isPay"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            case SKPaymentTransactionStateFailed:
//                [Help hideHUDWithTitle:SKPLocalizedString(@"The purchase failed, please try again")];
                [SVProgressHUD showErrorWithStatus:@"购买失败，请重试。"];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
            default:
//                [Help hideHUDWithTitle:SKPLocalizedString(@"The purchase failed, please try again")];
                [SVProgressHUD dismiss];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                break;
        }
    }
}


//购买成功之后 给用户权限
-(void)addUseCount{
//    [Help setObject:@"9999" forKey:haveCount];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"paySuccess" object:nil];
}



//结束后一定要销毁
- (void)dealloc{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
