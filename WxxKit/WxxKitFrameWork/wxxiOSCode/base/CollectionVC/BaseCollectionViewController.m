//
//  BaseCollectionViewController.m
//  WxxKit
//
//  Created by wengxianxun on 2018/2/27.
//  Copyright © 2018年 wengxianxun. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import "BaseCollectionViewCell.h"
@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)initCollectionVC{
    
    if (!self.collectionView) {
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = 5;
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowLayout];
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;
        
//        //注册Cell，必须要有
        [self.collectionView registerClass:[BaseCollectionViewCell class] forCellWithReuseIdentifier:@"BaseCollectionViewCell"];
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:self.collectionView];
    }
}

//cell数量
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

//section数量
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString * CellIdentifier = @"BaseCollectionViewCell";
        BaseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.5;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width, 85);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0,0, 0);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    //设置(Highlight)高亮下的颜色
//    [cell setBackgroundColor:[UIColor whiteColor]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    //设置(Nomal)正常状态下的颜色
//    [cell setBackgroundColor:[UIColor whiteColor]];
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
