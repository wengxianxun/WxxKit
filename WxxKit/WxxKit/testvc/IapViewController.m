//
//  IapViewController.m
//  wxxObjcUtil
//
//  Created by game just on 2017/7/16.
//  Copyright © 2017年 game just. All rights reserved.
//

#import "IapViewController.h"
#import "WxxIapStore.h"
@interface IapViewController ()<WxxIapStoreDelegate>
@property (nonatomic,strong)WxxIapStore *wiapstore;
@end

@implementation IapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *buyBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [buyBtn setTitle:@"购买非消耗" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    buyBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:buyBtn];
    
    
    UIButton *buyBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(100, 210, 100, 50)];
    [buyBtn2 setTitle:@"购买消耗" forState:UIControlStateNormal];
    [buyBtn2 addTarget:self action:@selector(buy2) forControlEvents:UIControlEventTouchUpInside];
    buyBtn2.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:buyBtn2];
    
    
    UIButton *buyBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(100, 210, 100, 50)];
    [buyBtn3 setTitle:@"重购" forState:UIControlStateNormal];
    [buyBtn3 addTarget:self action:@selector(buy3) forControlEvents:UIControlEventTouchUpInside];
    buyBtn3.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:buyBtn3];
}

-(void)buy{
    if (!self.wiapstore) {
        self.wiapstore = [[WxxIapStore alloc]init];
        self.wiapstore.delegate = self;
        
    }
    [self.wiapstore wxxBuyStartWithProductIdentifiers:[self.wiapstore wxxGetProductIdByAppbundleIdentifier:@"6"]];//开始购买
}

-(void)buy2{
    if (!self.wiapstore) {
        self.wiapstore = [[WxxIapStore alloc]init];
        self.wiapstore.delegate = self;
        
    }
    [self.wiapstore wxxBuyStartWithProductIdentifiers:[self.wiapstore wxxGetProductIdByAppbundleIdentifier:@"30"]];//开始购买
}

-(void)buy3{
    if (!self.wiapstore) {
        self.wiapstore = [[WxxIapStore alloc]init];
        self.wiapstore.delegate = self;
        
    }
    [self.wiapstore wxxBuyStartWithProductIdentifiers:[self.wiapstore wxxGetProductIdByAppbundleIdentifier:@"30"]];//开始购买
}

#pragma mark WxxIapStoreDelegate
-(void)WxxIapBuyResult:(BOOL)buyResult{
    
    if (buyResult) {
        NSLog(@"成功");
    }else{
        NSLog(@"失败");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
