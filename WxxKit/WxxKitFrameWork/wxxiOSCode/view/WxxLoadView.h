//
//  WxxLoadView.h
//  ZWYPopKeyWords
//
//  Created by weng xiangxun on 14/12/27.
//  Copyright (c) 2014年 ZWY. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface WxxLoadView : UIView
@property (nonatomic,assign)BOOL isLinkNet;
+ (WxxLoadView *)sharedInstance;

-(void)showself;
-(void)hideSelf;
@end
