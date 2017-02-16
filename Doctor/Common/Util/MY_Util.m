//
//  MY_Util.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_Util.h"

@implementation MY_Util

+ (void)saveAccount:(MY_AccountModel *)model {
    //准备路径:
    NSString *path = NSHomeDirectory();
    
    path = [path stringByAppendingPathComponent:@"accountModel.archiver"];
    //1:准备存储数据的对象
    NSMutableData *data = [NSMutableData data];
    //2:创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //3:开始归档
    [archiver encodeObject:model forKey:@"accountModel"];
    //4:完成归档
    [archiver finishEncoding];
    //5:写入文件当中
    BOOL result = [data writeToFile:path atomically:YES];
    if (result) {
        MY_Log(@"归档成功:%@",path);
    }else
    {
        MY_Log(@"归档不成功!!!");
    }
}

+ (MY_AccountModel *)getAccountModel {
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"accountModel.archiver"];
    //准备解档路径
    NSData *myData = [NSData dataWithContentsOfFile:path];
    //创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:myData];
    //反归档
    MY_AccountModel *accountModel = [MY_AccountModel new];
    accountModel = [unarchiver decodeObjectForKey:@"accountModel"];
    //完成反归档
    [unarchiver finishDecoding];
    
    return accountModel;
}

+ (BOOL)isLogin {
    return NO;
}

@end
