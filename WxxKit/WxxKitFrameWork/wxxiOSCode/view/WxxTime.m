//
//  WxxTime.m
//  WxxReadClient
//
//  Created by wengxianxun on 2018/2/24.
//  Copyright © 2018年 wxx. All rights reserved.
//

#import "WxxTime.h"

@implementation WxxTime

+(NSString *)nowTime{
    long startTimeTamp = time(NULL)*1000;//开始时间
    return [NSString stringWithFormat:@"%ld",startTimeTamp];
}
@end
