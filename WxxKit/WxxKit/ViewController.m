//
//  ViewController.m
//  wxxObjcUtil
//
//  Created by game just on 2017/7/6.
//  Copyright © 2017年 game just. All rights reserved.
//

#import "ViewController.h"
#import "ViewCollectionViewCell.h"
#import "IapViewController.h"
#import "WxxSKStoreReview.h"
typedef enum{
    setIap,
    setStoreReview,
}setType;

@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *listArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //预设功能
    //添加账号信息分组
    
    
    [self initListArr];
    [self initCollectionVC];
    // Do any additional setup after loading the view.
}



//设置功能列表
-(void)initListArr{
    self.listArr = [[NSMutableArray alloc]init];
    
    
    [self.listArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                             @"内购",@"text",
                             @"0",@"type",
                             [NSString stringWithFormat:@"%d",setIap],@"setType",nil]];
    
    [self.listArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                             @"评分",@"text",
                             @"0",@"type",
                             [NSString stringWithFormat:@"%d",setStoreReview],@"setType",nil]];
    
    
}


-(void)initCollectionVC{
    
    if (!self.collectionView) {
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = 5;
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        
        //注册Cell，必须要有
        [self.collectionView registerClass:[ViewCollectionViewCell class] forCellWithReuseIdentifier:@"ViewCollectionViewCell"];
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:self.collectionView];
    }
}


#pragma mark -- UICollectionViewDataSource
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {self.view.frame.size.width, 0};
        return size;
    }
    else
    {
        CGSize size = {self.view.frame.size.width, 0};
        return size;
    }
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.listArr.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * CellIdentifier = @"ViewCollectionViewCell";
    ViewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setBtnTitle:[[self.listArr objectAtIndex:indexPath.row] objectForKey:@"text"] type:[[[self.listArr objectAtIndex:indexPath.row] objectForKey:@"type"] intValue]];
    
    return cell;
    
}

#pragma mark --UICollectionViewDelegateFlowLayout

// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(self.view.frame.size.width, 50);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0,0, 0);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    BigClassData *bookData =[self.bookArrDic objectAtIndex:indexPath.row];
    
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    //设置(Highlight)高亮下的颜色
    [cell setBackgroundColor:[UIColor grayColor]];
    
    setType typp = (setType)[[[self.listArr objectAtIndex:indexPath.row] objectForKey:@"setType"] intValue];
    
    
    switch (typp) {
        case setIap:
            [self toIapVC];
            break;
        case setStoreReview:
            [WxxSKStoreReview wxxSKStoreReviewAction];
            break;
        default:
            break;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    //设置(Nomal)正常状态下的颜色
    [cell setBackgroundColor:[UIColor whiteColor]];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
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

-(void)toIapVC{
    
    IapViewController *iapVC = [[IapViewController alloc]init];
    [self presentViewController:iapVC animated:YES completion:^{
        
    }];
}
@end
