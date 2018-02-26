//
//  BaseViewController.h
//  WxxReadClient
//
//  Created by weng xiangxun on 2017/3/23.
//  Copyright © 2017年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic,assign)BOOL ynLoadData;

- (void)hidesTabBar:(BOOL)hidden;
-(void)showLoading; //显示居中加载动画
-(void)hideLoading; //隐藏居中加载动画
-(BOOL)isNetLink;
-(void)reloadBtnClick;
-(void)resetTopGradientLayerFrame:(CGRect )rect;
-(void)hideReloadUI;
@end
