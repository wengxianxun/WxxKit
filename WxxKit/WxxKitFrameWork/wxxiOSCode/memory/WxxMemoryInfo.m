//
//  WxxMemoryInfo.m
//  WxxKit
//
//  Created by game just on 2017/7/21.
//  Copyright © 2017年 wengxianxun. All rights reserved.
//

#import "WxxMemoryInfo.h"

@implementation WxxMemoryInfo


//单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString *)path{
//    @"Library/Private Documents/Cache"
    NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:path];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:cachePath])
    {
        [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (![fileManager fileExistsAtPath:cachePath]) return 0;
    NSEnumerator *childFilesEnumerator = [[fileManager subpathsAtPath:cachePath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [cachePath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    
    return folderSize/(1024.0*1024.0*1024.0);
}
-(float)usedSpaceAndfreeSpace{
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    NSFileManager* fileManager = [[NSFileManager alloc ]init];
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    //    NSNumber *totalSpace = [fileSysAttributes objectForKey:NSFileSystemSize];
    //    NSString  * str= [NSString stringWithFormat:@"已占用%0.1fG/剩余%0.1fG",([totalSpace longLongValue] - [freeSpace longLongValue])/1024.0/1024.0/1024.0,[freeSpace longLongValue]/1024.0/1024.0/1024.0];
    //    NSLog(@"--------%@",str);
    return [freeSpace longLongValue]/1024.0/1024.0/1024.0;
}

@end
