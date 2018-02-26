//
//  NSString+wxx.h
//  driftbottle
//
//  Created by weng xiangxun on 13-8-18.
//  Copyright (c) 2013年 weng xiangxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString(wxx)
-(void)test;

-(CGFloat)calculateTextHeight:(CGFloat)widthInput Content:(NSString *)strContent font:(UIFont*)font;
-(CGSize)calculateTextWidthFont:(UIFont*)font maxWidth:(CGFloat)maxWidth;
-(CGFloat)calculateTextWidth:(NSString *)strContent font:(UIFont*)font;
@end
