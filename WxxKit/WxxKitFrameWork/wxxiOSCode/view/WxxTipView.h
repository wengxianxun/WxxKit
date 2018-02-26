//
//  WxxTipView.h
//  WxxReadClient
//
//  Created by linxiaolong on 2017/3/22.
//  Copyright © 2017年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxxTipView : UIView
+ (WxxTipView *)sharedInstance;

-(void)showText:(NSString*)string;
-(void)showText:(NSString *)string yesBtn:(NSString*)yesStr;
-(void)showPopText:(NSString*)str;
-(void)showPopText:(NSString*)str time:(float)time;
@end
