//
//  WxxTipView.m
//  WxxReadClient
//
//  Created by linxiaolong on 2017/3/22.
//  Copyright © 2017年 wxx. All rights reserved.
//

#import "WxxTipView.h"

@interface WxxTipView()
@property (nonatomic,strong)UILabel *contentLb;
@end

@implementation WxxTipView


static WxxTipView *_shared = nil;

+ (WxxTipView *)sharedInstance{
    if (!_shared) {
        _shared = [[self alloc] init];
        
    }
    return _shared;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:CGRectMake(([[UIScreen mainScreen] bounds].size.width-250)/2, ([[UIScreen mainScreen] bounds].size.height-65)/2, 250, 65)];
    if (self) {
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 6.0;
        //        [self blurScreen:YES];
        UIView *black = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        black.backgroundColor = [UIColor blackColor];
        black.alpha = 0.9;
        [self addSubview:black];
        
        self.contentLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_contentLb setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:20.0]];
        self.contentLb.textAlignment = NSTextAlignmentCenter;
        _contentLb.textColor = [UIColor whiteColor];
        [black addSubview:_contentLb];
        self.contentLb.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSArray* vLabelConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contentLb(==black)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentLb,black)];
        [NSLayoutConstraint activateConstraints:vLabelConstraintArray];
        NSArray* vLabelConstraintArray2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_contentLb(==black)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentLb,black)];
        [NSLayoutConstraint activateConstraints:vLabelConstraintArray2];
        self.alpha = 0;
    }
    return self;
}


-(void)showPopText:(NSString*)str time:(float)time{
    [self.contentLb setText:str];
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0;
    }completion:^(BOOL finished) {
    }];
    [self performSelector:@selector(hidePopView:) withObject:nil afterDelay:time];
}

-(void)showPopText:(NSString*)str{
    [self.contentLb setText:str];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0;
    }completion:^(BOOL finished) {
    }];
    [self performSelector:@selector(hidePopView:) withObject:nil afterDelay:2];
}

-(void)hidePopView:(id*)object{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
    }];
}
-(void)showText:(NSString*)string{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:string message:nil
                                                   delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    //    alert.backgroundColor = [UIColor blackColor];
    
    [alert show];
    [self performSelector:@selector(hideSelf:) withObject:alert afterDelay:1.5];
}

-(void)showText:(NSString *)string yesBtn:(NSString*)yesStr{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:string
                                                   delegate:self cancelButtonTitle:yesStr otherButtonTitles:nil];
    [alert show];
    
}


-(void)hideSelf:(UIAlertView*)alert{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
