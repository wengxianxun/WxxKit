//
//  WxxLoadView.m
//  ZWYPopKeyWords
//
//  Created by weng xiangxun on 14/12/27.
//  Copyright (c) 2014年 ZWY. All rights reserved.
//

#import "WxxLoadView.h"
#import "Reachability.h"
@interface WxxLoadView ()

@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicator;
@property(strong) Reachability * internetConnectionReach;
@end
@implementation WxxLoadView
#pragma mark -
#pragma mark Singleton

static WxxLoadView *_shared = nil;

+ (WxxLoadView *)sharedInstance{
    if (!_shared) {
        
        _shared = [[self alloc] init];
        
    }
    return _shared;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    if (self) {
        self.isLinkNet = NO;
        self.backgroundColor = [UIColor clearColor];
        
        _backView = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-80)/2, (self.frame.size.height-80)/2, 80, 80)];
//        [_backView blurScreen:YES alp:0.99];
        _backView.backgroundColor = [UIColor blackColor];
//        _backView.layer.borderWidth = 1;
//        _backView.layer.borderColor = WXXCOLOR(255, 255, 255, 0.9).CGColor;
        _backView.layer.cornerRadius = 40;
//        _backView.layer.masksToBounds = YES;
        _backView.layer.shadowPath =  [UIBezierPath bezierPathWithRoundedRect:_backView.bounds cornerRadius:40].CGPath;
//        _backView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_backView.bounds].CGPath;
        //        view.backgroundColor = WXXCOLOR(255, 255, 255, 0.6);
//        _backView.backgroundColor = WXXCOLOR(255, 255, 255, 0.9);
        //        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"123123.png"]];
        _backView.layer.shadowOffset = CGSizeMake(0, 1);
        _backView.layer.shadowRadius = 1;
        _backView.layer.shadowColor = [UIColor blackColor].CGColor;
        _backView.layer.shadowOpacity = 0.5;
        
        self.backView.alpha = 0.0;
        [self addSubview:_backView];
        
//        self.layer.masksToBounds = YES;
//        self.backgroundColor = [UIColor blackColor];
//        self.layer.cornerRadius = 3.0;
//        [self blurScreen:YES];
        
        //加载旋转的风火轮
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-37)/2, (CGRectGetHeight(self.frame)-37)/2, 37, 37)];
        _activityIndicator.hidesWhenStopped = NO;
//        _activityIndicator.frame = CGRectMake(0, 0, 50, 50);
        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//        _activityIndicator.center =self.center;
        _activityIndicator.color = [UIColor whiteColor];
        _activityIndicator.alpha = 0;
        [self addSubview:_activityIndicator];
     
        self.alpha = 0;
        
        [self checkNet];
//         [self.spinner startAnimating];
    }
    return self;
}
-(void)showself{
//    [self.activityIndicator startAnimating];
//    self.activityIndicator.alpha = 0;
    self.alpha = 1.0;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.backView.alpha = 0.9;
        self.activityIndicator.alpha = 1.0;
        
    }completion:^(BOOL finished) {
//       self.activityIndicator.alpha = 1.0;;
    }];
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.springBounciness = 15;
//    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
//    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
//    [self performSelector:@selector(hideSelf) withObject:nil afterDelay:2.0];
}

-(void)hideSelf{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
        self.backView.alpha = 0.0;
        self.activityIndicator.alpha = 0.0;
    }completion:^(BOOL finished) {

    }];
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.springBounciness = 15;
//    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
//    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.4, 0.4)];
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//
}

-(void)checkNet{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    self.internetConnectionReach = [Reachability reachabilityForInternetConnection];
    [self.internetConnectionReach startNotifier];
    [self updateInterfaceWithReachability:self.internetConnectionReach];
}

/*!
 * Called by Reachability whenever status changes.
 */
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability
{
    if (reachability == self.internetConnectionReach)
    {
        NetworkStatus netStatus = [reachability currentReachabilityStatus];
        BOOL connectionRequired = [reachability connectionRequired];
        NSString* statusString = @"";
        
        switch (netStatus)
        {
            case NotReachable:        {
                statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
                
                connectionRequired = NO;
                self.isLinkNet = NO;
                break;
            }
                
            case ReachableViaWWAN:        {
                statusString = NSLocalizedString(@"Reachable WWAN", @"");
                self.isLinkNet = YES;
                break;
            }
            case ReachableViaWiFi:        {
                statusString= NSLocalizedString(@"Reachable WiFi", @"");
                self.isLinkNet = YES;
                break;
            }
        }
    }
    
}


- (void)configureTextField:(UITextField *)textField imageView:(UIImageView *)imageView reachability:(Reachability *)reachability
{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];
    NSString* statusString = @"";
    
    switch (netStatus)
    {
        case NotReachable:        {
            statusString = NSLocalizedString(@"Access Not Available", @"Text field text for access is not available");
            imageView.image = [UIImage imageNamed:@"stop-32.png"] ;
            /*
             Minor interface detail- connectionRequired may return YES even when the host is unreachable. We cover that up here...
             */
            connectionRequired = NO;
            break;
        }
            
        case ReachableViaWWAN:        {
            statusString = NSLocalizedString(@"Reachable WWAN", @"");
            imageView.image = [UIImage imageNamed:@"WWAN5.png"];
            break;
        }
        case ReachableViaWiFi:        {
            statusString= NSLocalizedString(@"Reachable WiFi", @"");
            imageView.image = [UIImage imageNamed:@"Airport.png"];
            break;
        }
    }
    
    if (connectionRequired)
    {
        NSString *connectionRequiredFormatString = NSLocalizedString(@"%@, Connection Required", @"Concatenation of status string with connection requirement");
        statusString= [NSString stringWithFormat:connectionRequiredFormatString, statusString];
    }
    textField.text= statusString;
}
@end
