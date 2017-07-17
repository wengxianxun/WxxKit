//
//  ViewCollectionViewCell.m
//  wxxObjcUtil
//
//  Created by game just on 2017/7/16.
//  Copyright © 2017年 game just. All rights reserved.
//

#import "ViewCollectionViewCell.h"

@interface ViewCollectionViewCell()
@property (nonatomic,strong)UILabel *titleLb;
@property (nonatomic,strong)UILabel *contextLb;
@property (nonatomic,strong)UISwitch *switchView;
@property (nonatomic,assign)int type;
@end
@implementation ViewCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self setCellView];
    return self;
}


#pragma mark - Setup Method
- (void)setCellView
{
//    self.backgroundColor = WXXCOLOR(242, 242, 242, 1);
    
    self.titleLb = [[UILabel alloc]init];
    self.titleLb.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:self.titleLb];
    
    self.contextLb = [[UILabel alloc]init];
    //    self.contextLb.backgroundColor = [UIColor blackColor];
    self.contextLb.textAlignment = NSTextAlignmentRight;
    self.contextLb.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.contextLb];
    self.contextLb.hidden = YES;
    [self initSwitch];
    
    
    self.titleLb.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLb]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_titleLb)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_titleLb]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_titleLb)]];
    self.contextLb.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_contextLb]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_contextLb)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_contextLb(90)]-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(_contextLb)]];
}




-(void)initSwitch{
    if (!_switchView) {
        _switchView = [[UISwitch alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-80, 0, 100, 20)];
        
        [self.contentView addSubview:_switchView];
        [_switchView addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    _switchView.hidden = YES;
}



//        //			cell.accessoryView = self.pushSwitch;
-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        switch (self.type) {
            case 1:
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"3g"];
                break;
            default:
                break;
        }
    }else {
        switch (self.type) {
            case 1:
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"3g"];
                break;
            default:
                break;
        }
    }
}


-(void)setBtnTitle:(NSString*)str type:(int)type{
    self.titleLb.text = str;
    self.type = type;
    self.contextLb.hidden = YES;
    _switchView.hidden = YES;
    if(type == 111){
        self.titleLb.alpha = 0.5;
    }else{
        self.titleLb.alpha = 1;
    }
    
    if (type == 1) {
        _switchView.hidden = NO;
        BOOL locked  = [[[NSUserDefaults standardUserDefaults] objectForKey:@"3g"] boolValue];
        if (locked) {
            _switchView.on = YES;//设置初始为ON的一边
        }
        self.titleLb.alpha = 0.5;
    }else if(type == 2){
        
        self.titleLb.alpha = 0.5;
    }else if(type == 3){
         
    }else if(type == 0){
        
        self.contextLb.text = @">";
        
        self.contextLb.hidden = NO;
        NSLog(@"%d",type);
    }
    
    
}

@end
