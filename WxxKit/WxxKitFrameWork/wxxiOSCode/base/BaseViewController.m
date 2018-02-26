//
//  BaseViewController.m
//  WxxReadClient
//
//  Created by weng xiangxun on 2017/3/23.
//  Copyright © 2017年 wxx. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
//@implementation UINavigationBar (CustomHeight)
//- (CGSize)sizeThatFits:(CGSize)size {
//    // Change navigation bar height. The height must be even, otherwise there will be a white line above the navigation bar.
//    CGSize newSize = CGSizeMake(self.frame.size.width, 74);
//    return newSize;
//}
//
//-(void)layoutSubviews {
//    [super layoutSubviews];
//
//    CGRect barFrame = self.frame;
//    barFrame.size.height = 74;
//    self.frame = barFrame;
//
//    // Make items on navigation bar vertically centered.
//    int i = 0;
//    for (UIView *view in self.subviews) {
//        if (i == 0)
//            continue;
//        float centerY = self.bounds.size.height / 2.0f;
//        CGPoint center = view.center;
//        center.y = centerY;
//        view.center = center;
//    }
//}
//@end
@interface BaseViewController ()
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicator;
@property (nonatomic,strong)CAGradientLayer *topgradientLayer;
@property (nonatomic,strong)UIButton *reloadBtn;
@property (nonatomic,strong)UILabel *reloadLb;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    //    self.edgesForExtendedLayout = UIRectEdgeNone;
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:wxxColorTitleTextColor}];
    
    // Do any additional setup after loading the view.
    
}

-(void)initRealoadBtn{
    if (!self.reloadLb) {
        self.reloadLb  = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        self.reloadLb.text = @"目前无法连接";
        self.reloadLb.textColor = [UIColor blackColor];
        [self.view addSubview:self.reloadLb];
        self.reloadLb.textAlignment = NSTextAlignmentCenter;
        self.reloadLb.font = [UIFont systemFontOfSize:25];
        self.reloadLb.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary* lbviews = NSDictionaryOfVariableBindings(_reloadLb);
        //设置高度
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_reloadLb(50)]-orgy-|" options:0 metrics:@{@"orgy":@(self.view.frame.size.height/2)} views:lbviews]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_reloadLb]|" options:0 metrics:nil views:lbviews]];
    }
    if (!self.reloadBtn) {
        self.reloadBtn = [[UIButton alloc]init];
        [self.view addSubview:self.reloadBtn];
        [self.view bringSubviewToFront:self.reloadBtn];
        [self.reloadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.reloadBtn.layer.borderWidth = 1;
        self.reloadBtn.layer.cornerRadius = 3;
        self.reloadBtn.layer.borderColor = [UIColor blackColor].CGColor;
        [self.reloadBtn setTitle:@"重试" forState:UIControlStateNormal];
        self.reloadBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [self.reloadBtn addTarget:self action:@selector(reloadBtnClick) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary* views = NSDictionaryOfVariableBindings(_reloadBtn);
//        //设置高度
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_reloadBtn(45)]" options:0 metrics:nil views:views]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-orgy-[_reloadBtn(45)]" options:0 metrics:@{@"orgy":@(self.view.frame.size.height/2+8)} views:views]];
        //设置宽度
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_reloadBtn(120)]" options:0 metrics:nil views:views]];
//        //垂直居中
//        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_reloadBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        //水平居中
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_reloadBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        //end
    }
}

-(void)hideReloadUI{
    self.reloadBtn.hidden = YES;
    self.reloadLb.hidden = YES;
}

-(void)reloadBtnClick{
    if (![self isNetLink]) {
        self.reloadBtn.hidden = NO;
        self.reloadLb.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.reloadLb.alpha = 0.2;
            self.reloadBtn.alpha = 0.2;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.reloadLb.alpha = 1;
                self.reloadBtn.alpha = 1;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }else{
        self.reloadBtn.hidden = YES;
        self.reloadLb.hidden = YES;
    }
}

-(BOOL)isNetLink{
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if([appDlg isReachable]){
        return YES;
    }else{
        [self initRealoadBtn];
        return NO;
    }
}

-(void)initTopGradientLayer{
    if (!_topgradientLayer) {
        _topgradientLayer = [CAGradientLayer layer];  // 设置渐变效果
        _topgradientLayer.frame = CGRectMake(0, -0.5, self.view.frame.size.width, 7);
        _topgradientLayer.colors = [NSArray arrayWithObjects:
                                    (id)[[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2] CGColor],
                                    (id)[[UIColor clearColor] CGColor],
                                    (id)[[UIColor clearColor] CGColor], nil];
        _topgradientLayer.startPoint = CGPointMake(0, 0);
        _topgradientLayer.endPoint = CGPointMake(0, 1.0);
        _topgradientLayer.hidden = YES;
        [self.view.layer addSublayer:_topgradientLayer];
    }
}


-(void)resetTopGradientLayerFrame:(CGRect )rect{
    
    _topgradientLayer.frame = rect;//CGRectMake(0, -0.5, self.view.frame.size.width, 7);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= 0) {
        //        [UIView animateWithDuration:0.5 animations:^{
        _topgradientLayer.hidden = YES;
        //        }];
        
    }else{
        if (_topgradientLayer.hidden) {
            _topgradientLayer.hidden = NO;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    
    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];
    
    //    CGRect rect = self.navigationController.navigationBar.frame;
    //    self.navigationController.navigationBar.frame = CGRectMake(rect.origin.x,rect.origin.y,rect.size.width,64);
    
    //    NSLog(@"修改前");
    //    [self printViewHierarchy:self.navigationController.navigationBar];
    //
    //    //修改NavigaionBar的高度
    //    self.navigationController.navigationBar.frame = CGRectMake(0, 20, 320, 100);
    //
    //    NSLog(@"\n修改后");
    //    [self printViewHierarchy:self.navigationController.navigationBar];
    //    [self.navigationController.navigationBar sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, 64)];
    //去除导航栏下方的横线
    //    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:wxxColorBackground]
    //                       forBarPosition:UIBarPositionAny
    //                           barMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //    [self initTopGradientLayer];
}

- (void)printViewHierarchy:(UIView *)superView
{
    static uint level = 0;
    for(uint i = 0; i < level; i++){
        printf("\t");
    }
    
    const char *className = NSStringFromClass([superView class]).UTF8String;
    const char *frame = NSStringFromCGRect(superView.frame).UTF8String;
    printf("%s:%s\n", className, frame);
    
    ++level;
    for(UIView *view in superView.subviews){
        [self printViewHierarchy:view];
    }
    --level;
}


- (UIImage*) imageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(void)showLoading{
    if (!_activityIndicator) {
        //加载旋转的风火轮
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.hidesWhenStopped = NO;
        _activityIndicator.color = [UIColor blackColor];
        //
        [self.view addSubview:_activityIndicator];
        [self.view bringSubviewToFront:_activityIndicator];
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        NSDictionary* views = NSDictionaryOfVariableBindings(_activityIndicator);
        //设置高度
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_activityIndicator(60)]" options:0 metrics:nil views:views]];
        //设置宽度
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[_activityIndicator(60)]" options:0 metrics:nil views:views]];
        //垂直居中
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        //水平居中
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_activityIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
        //end
    }
    _activityIndicator.alpha = 1;
    [_activityIndicator startAnimating];
}

-(void)hideLoading{
    
    [_activityIndicator stopAnimating];
    _activityIndicator.alpha = 0;
}

- (void)hidesTabBar:(BOOL)hidden{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    for (UIView *view in self.tabBarController.view.subviews) {
        self.tabBarController.view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
        if ([view isKindOfClass:[UITabBar class]]) {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width , view.frame.size.height)];
                
            }else{
                [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height - 49, view.frame.size.width, view.frame.size.height)];
                
            }
        }else{
            if([view isKindOfClass:NSClassFromString(@"UITransitionView")]){
                if (hidden) {
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
                    
                }else{
                    
                    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 49 )];
                    
                }
            }
        }
    }
    [UIView commitAnimations];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

