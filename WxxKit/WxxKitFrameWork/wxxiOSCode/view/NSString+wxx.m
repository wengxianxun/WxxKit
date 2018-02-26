//
//  NSString+wxx.m
//  driftbottle
//
//  Created by weng xiangxun on 13-8-18.
//  Copyright (c) 2013年 weng xiangxun. All rights reserved.
//

#import "NSString+wxx.h"

@implementation NSString (wxx)

-(void)test{
    
} 
//计算文本所占高度
//2个参数：宽度和文本内容
-(CGFloat)calculateTextHeight:(CGFloat)widthInput Content:(NSString *)strContent font:(UIFont*)font{
    CGSize constraint = CGSizeMake(widthInput, MAXFLOAT);
//    CGSize size = [strContent sizeWithFont:font constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize size = [self boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
 
//    strContent boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>
    //    CGFloat height = MAX(size.height, 44.0f);
    //
    //    NSLog(@"高度:%f",size.height);
    return size.height;
}

//计算 宽度
-(CGFloat)calculateTextWidth:(NSString *)strContent font:(UIFont*)font{
    //    CGSize constraint = CGSizeMake(heightInput, heightInput);
    CGFloat constrainedSize = 26500.0f; //其他大小也行
//    CGSize size = [strContent sizeWithFont:font constrainedToSize:CGSizeMake(constrainedSize, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize constraint = CGSizeMake(constrainedSize, MAXFLOAT);
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize size = [self boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    //    CGFloat height = MAX(size.height, 44.0f);
    return size.width;
}

//计算 宽度
-(CGSize)calculateTextWidthFont:(UIFont*)font maxWidth:(CGFloat)maxWidth{
    //    CGSize constraint = CGSizeMake(heightInput, heightInput);
    //    CGFloat constrainedSize = 26500.0f; //其他大小也行
//    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(maxWidth, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    //    CGFloat height = MAX(size.height, 44.0f);
    return size;
}
@end
