//
//  WxxSKStoreReview.m
//  WxxKitFrameWork
//
//  Created by wengxianxun on 2018/2/24.
//  Copyright © 2018年 wengxianxun. All rights reserved.
//

#import "WxxSKStoreReview.h"
#import <StoreKit/StoreKit.h>
@implementation WxxSKStoreReview

/**
 * 只能评分，不能编写评论
 * 有次数限制，一年只能使用三次
 * 使用次数超限后，需要跳转appstore
 */
+ (void)wxxSKStoreReviewAction{
    
    //10次之内不可以打开评论
    long count = [[NSUserDefaults standardUserDefaults]integerForKey:@"wxxreview"];
    count ++;
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"wxxreview"];
    if (count<=10) {
        return;
    }
    count = 0;
    [[NSUserDefaults standardUserDefaults] setInteger:count forKey:@"wxxreview"];
    //仅支持iOS10.3+（需要做校验） 且每个APP内每年最多弹出3次评分alart
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
        //防止键盘遮挡
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [SKStoreReviewController requestReview];
    }
//    else {
//
//        //不论iOS 版本均可使用APP内部打开网页形式，跳转到App Store 直接编辑评论
//
//        NSString *APPID = [PlistReader valueForKeyInConfig:@"APP_ID"];
//
//        NSString *nsStringToOpen = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",APPID];
//
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
//
//    }
}


@end
