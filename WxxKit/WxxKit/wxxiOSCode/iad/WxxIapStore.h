//
//  WxxIapStore.h
//  driftbottle
//
//  Created by weng xiangxun on 13-11-18.
//  Copyright (c) 2013年 weng xiangxun. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "WxxKitConfig.h"
#define BUYSECCUSS YES //购买成功
#define BUYERROR   NO   //购买失败

@protocol WxxIapStoreDelegate

-(void)wxxIapStoreDelegateIapBuyResult:(BOOL)buyResult;
-(void)wxxIapStoreDelegateRestoreProducts:(NSArray *)productArr;
@end

/**
 * 内购之所以不使用单例是因为使用完我希望马上释放
 * 之所以使用代理而不用block是因为个人的喜好原因
 */
@interface WxxIapStore : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>{

}
@property (nonatomic,weak)id <WxxIapStoreDelegate>delegate;//购买结果代理

/**
 * 步骤1根据产品标示开始购买
 */
-(void)wxxBuyStartWithProductIdentifiers:(NSString *)productId;

/**
 * 重购，一次性购买的物品需要提供重购按钮，否则审核不让通过
 */
-(void)wxxIapRestore;
te
/**
 * 获取App的包名
 * 一般内购的标示前缀使用对应App的包名加上后缀， 比如 com.xxx.app.6 , 这样比较一致，好控制
 */
-(NSString*)wxxGetProductIdByAppbundleIdentifier:(NSString *)Suffix;
@end
