//
//  WxxIapStore.m
//  driftbottle
//
//  Created by weng xiangxun on 13-11-18.
//  Copyright (c) 2013年 weng xiangxun. All rights reserved.
//

#import "WxxIapStore.h"

@interface WxxIapStore()
@property (nonatomic,strong)NSString* productId;

-(void)wxxIapBuyResult:(BOOL)buyResult;
-(void)wxxGetProductInfo;

@end

@implementation WxxIapStore

-(void)dealloc{
    
    self.delegate = nil;
    self.productId = nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        // 监听购买结果
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}

/**
 * 购买结果代理
 */
-(void)wxxIapBuyResult:(BOOL)buyResult{
    if (self.delegate) {
        [self.delegate WxxIapBuyResult:buyResult];
    }
}

/**
 * 步骤1根据产品标示开始购买
 */
-(void)wxxBuyStartWithProductIdentifiers:(NSString *)productId{
    self.productId = productId;
    //非空判断
    if (!self.productId) {
        [self wxxIapBuyResult:BUYERROR];
        return;
    }
    if ([SKPaymentQueue canMakePayments]) {
        // 执行下面提到的第5步：
        [self wxxGetProductInfo];
    } else {
        NSLog(@"失败，用户禁止应用内付费购买.");
    }
}

/**
 * 获取产品信息
 */
- (void)wxxGetProductInfo{
    
    NSSet * set = [NSSet setWithArray:@[self.productId]];
    SKProductsRequest * request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
    request.delegate = self;
    [request start];
}


#pragma mark SKProductsRequestDelegate
//步骤3
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *myProduct = response.products;
    if (myProduct.count == 0) {
        NSLog(@"无法获取产品信息，购买失败。");
        [self wxxIapBuyResult:BUYERROR];
        return;
    }
    SKPayment * payment = [SKPayment paymentWithProduct:myProduct[0]];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

// 步骤4
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased://交易完成
                NSLog(@"transactionIdentifier = %@", transaction.transactionIdentifier);
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self restoreTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                NSLog(@"交易中");

                break;
            default:
                break;
        }
    }
}

/**
 * 当一个交易完成finished后(无论是失败还是成功)，则会触发此方法。可以不对此方法进行处理，但可以对于已经完成的transaction在此处对用户交互信息进行修改，如移除掉已经完成的transaction
 */
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray *)transactions __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    NSLog(@"paymentQueue");
}

// Sent when an error is encountered while adding transactions from the user's purchase history back to the queue.
// 当尝试恢复还原交易信息时，若出错，则会触发此方法，无需做处理。
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0){
    NSLog(@"paymentQueue");
//    [self sendObject:@"1"];
}
 

// Sent when the download state has changed.
// 当transaction队列的一个或多个transaction的数据被提交或更新后，会触发此方法，无需处理。
- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray *)downloads __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0){
NSLog(@"paymentQueue");
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction {
    // Your application should implement these two methods.
    NSString * productIdentifier = transaction.payment.productIdentifier;
//    NSString * receipt = [transaction.transactionReceipt base64EncodedString];
    if ([productIdentifier length] > 0) {
        // 向自己的服务器验证购买凭证
    }
    [self wxxIapBuyResult:BUYSECCUSS];
    // Remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction {
    NSString *detail;
    if (transaction.error != nil) {
        switch (transaction.error.code) {
                
            case SKErrorUnknown:
                
                NSLog(@"SKErrorUnknown");
                detail = @"未知的错误，您可能正在使用越狱手机";
                break;
                
            case SKErrorClientInvalid:
                
                NSLog(@"SKErrorClientInvalid");
                detail = @"当前苹果账户无法购买商品(如有疑问，可以询问苹果客服)";
                break;
                
            case SKErrorPaymentCancelled:
                
                NSLog(@"SKErrorPaymentCancelled");
                detail = @"订单已取消";
                break;
            case SKErrorPaymentInvalid:
                NSLog(@"SKErrorPaymentInvalid");
                detail = @"订单无效(如有疑问，可以询问苹果客服)";
                break;
                
            case SKErrorPaymentNotAllowed:
                NSLog(@"SKErrorPaymentNotAllowed");
                detail = @"当前苹果设备无法购买商品(如有疑问，可以询问苹果客服)";
                break;
                
            case SKErrorStoreProductNotAvailable:
                NSLog(@"SKErrorStoreProductNotAvailable");
                detail = @"当前商品不可用";
                break;
                
            default:
                
                NSLog(@"No Match Found for error");
                detail = @"未知错误";
                break;
        }
    }
    if(transaction.error.code != SKErrorPaymentCancelled) {
        
        NSLog(@"购买失败%@----%@",transaction.error.domain,transaction.error.description);

         [self wxxIapBuyResult:BUYERROR];
    } else {
        NSLog(@"用户取消交易");
         [self wxxIapBuyResult:BUYERROR];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSArray *array = queue.transactions;
    if ([array count]==0) {
        NSLog(@"没有已购买项目。");
//        [self sendObject:@"1"];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:LOCAL("提示") message:LOCAL("没有已购买项目") delegate:Nil cancelButtonTitle:LOCAL("确定") otherButtonTitles:Nil, nil];
//        [alertView show];
    }else{
//        for (int i =0 ; i<[array count]; i++) {
//            SKPaymentTransaction *skPay = array[i];
//             
//            [self sendObject:array];
//        }
    }
}
- (void)restoreTransaction:(SKPaymentTransaction *)transaction {
    // 对于已购商品，处理恢复购买的逻辑
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}


/**
 * 重购，一次性购买的物品需要提供重购按钮，否则审核不让通过
 */
-(void)wxxIapRestore{
    // Assign an observer to monitor the transaction status.
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    // Request to restore previous purchases.
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

/**
 * 获取App的包名
 * 一般内购的标示前缀使用对应App的包名加上后缀， 比如 com.xxx.app.6 , 这样比较一致，好控制
 */
-(NSString*)wxxGetProductIdByAppbundleIdentifier:(NSString *)Suffix{
    
    NSString *productId = [NSString stringWithFormat:@"%@.%@",[[NSBundle mainBundle] bundleIdentifier],Suffix];
    NSLog(@"内购productId:%@",productId);
    
    return productId;
}


@end
