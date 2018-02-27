//
//  BaseNetControll.h
//  WxxReadClient
//
//  Created by wengxianxun on 2018/2/27.
//  Copyright © 2018年 wxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseNetControll : NSObject
@property (nonatomic,assign)BOOL isReachable;

+ (BaseNetControll *)sharedInstance;

-(void)initReachability;
@end
