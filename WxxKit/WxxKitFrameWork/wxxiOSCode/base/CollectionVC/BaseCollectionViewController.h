//
//  BaseCollectionViewController.h
//  WxxKit
//
//  Created by wengxianxun on 2018/2/27.
//  Copyright © 2018年 wengxianxun. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic)UICollectionView *collectionView;
@end
