//
//  BaseViewModel.m
//  WxxReadClient
//
//  Created by linxiaolong on 2017/3/17.
//  Copyright © 2017年 wxx. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel
#pragma 接收穿过来的block
-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
                 WithErrorBlock: (ErrorCodeBlock) errorBlock
               WithFailureBlock: (FailureBlock) failureBlock
{
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    _failureBlock = failureBlock;
}
//
//-(void)reqBookClass{
//    [SVHTTPRequest GET:@""
//            parameters:nil
//            completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
//        
//    }];
//}
@end
