//
//  BaseNetControll.m
//  WxxReadClient
//
//  Created by wengxianxun on 2018/2/27.
//  Copyright © 2018年 wxx. All rights reserved.
//

#import "BaseNetControll.h"
#import "Reachability.h"

@interface BaseNetControll()

@property (nonatomic,strong)Reachability *hostReach;
@end

@implementation BaseNetControll

static BaseNetControll *_shared = nil;
/**
 数据库采用单例模式: 不必每个地方去管理
 */
+ (BaseNetControll *)sharedInstance{
    if (!_shared) {
        _shared = [[self alloc] init];
    }
    return _shared;
}

-(void)initReachability{
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    //开始监听，会启动一个run loop
    [self.hostReach startNotifier];
}
-(void)reachabilityChanged:(NSNotification *)note{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    self.isReachable = YES;
    if(status == NotReachable)
    {
        self.isReachable = NO;
        return;
    }
    if (status==ReachableViaWiFi||status==ReachableViaWWAN) {
        self.isReachable = YES;
    }
}
@end
