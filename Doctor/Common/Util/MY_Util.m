//
//  MY_Util.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_Util.h"
#import "SDImageCache.h"
@implementation MY_Util

+ (void)saveAccount:(MY_AccountModel *)model {
    //准备路径:
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/account.archiver"];
    
    //1:准备存储数据的对象
    NSMutableData *data = [NSMutableData data];
    //2:创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //3:开始归档
    [archiver encodeObject:model forKey:@"account"];
    //4:完成归档
    [archiver finishEncoding];
    //5:写入文件当中
    BOOL result = [data writeToFile:path atomically:YES];
    if (result) {
        MY_Log(@"归档成功:%@",path);
    } else {
        MY_Log(@"归档不成功!!!");
    }
}

+ (MY_AccountModel *)getAccountModel {
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/account.archiver"];
    //准备解档路径
    NSData *myData = [NSData dataWithContentsOfFile:path];
    //创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:myData];
    //反归档
    MY_AccountModel *accountModel = [MY_AccountModel new];
    accountModel = [unarchiver decodeObjectForKey:@"account"];
    //完成反归档
    [unarchiver finishDecoding];
    return accountModel;
}

+ (NSString *)getUid {
    MY_AccountModel *model = [self getAccountModel];
    if (model.uid.length) {
         return model.uid;
    }
    return @"";
}

+ (void)removeAccount {
    NSString *path = NSHomeDirectory();
    path = [path stringByAppendingPathComponent:@"Documents/account.archiver"];
    NSError *error = nil;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        if (error) {
            MY_Log(@"移除文件失败，错误信息：%@", error);
        } else {
            MY_Log(@"成功移除文件");
        }
    } else {
        MY_Log(@"文件不存在");
    }
}

+ (BOOL)isLogin {
    MY_AccountModel *accountModel = [self getAccountModel];
    if (accountModel.uid.length) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString*)convertDate:(NSNumber*)timestamp {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp longValue]];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-M-d"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString*)convertDate:(NSNumber*)timestamp formatString:(NSString*)format {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp longValue]];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (UIColor*)setColorWithInt: (int)newColor {
    int r = (newColor >> 16) & 0xff;
    int g = (newColor >> 8) & 0xff;
    int b = newColor & 0xff;
    int a = (newColor >> 24) & 0xff;
    if (a == 0) {
        a = 0xff;
    }
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

+ (NSString *)getCacheSize {
    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    if (size < 1024) {// 小于1k
        return [NSString stringWithFormat:@"%ldB",(long)size];
    }else if (size < 1024 * 1024){// 小于1m
        CGFloat aFloat = size/1024;
        return [NSString stringWithFormat:@"%.0fK",aFloat];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        CGFloat aFloat = size/(1024 * 1024);
        return [NSString stringWithFormat:@"%.1fM",aFloat];
    }else{
        CGFloat aFloat = size/(1024*1024*1024);
        return [NSString stringWithFormat:@"%.1fG",aFloat];
    }
}

+ (void)pushAnimationFromVC:(UIViewController*)fromVC toVC:(UIViewController*)toVC {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.38;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [fromVC.navigationController.view.layer addAnimation:transition forKey:nil];
    
    fromVC.navigationController.navigationBarHidden = NO;
    
    [fromVC.navigationController pushViewController:toVC animated:NO];
}

+ (void)popAnimationFromVC:(UIViewController*)fromVC toVC:(UIViewController*)toVC {
    CATransition *transition = [CATransition animation];
    transition.duration =0.38;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [fromVC.navigationController.view.layer addAnimation:transition forKey:nil];
    fromVC.navigationController.navigationBarHidden = NO;
    
    [fromVC.navigationController popToViewController:toVC animated:NO];
}

+ (void)popAnimationViewController:(UIViewController*)VC {
    CATransition *transition = [CATransition animation];
    transition.duration =0.38;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [VC.navigationController.view.layer addAnimation:transition forKey:nil];
    VC.navigationController.navigationBarHidden = NO;
    
    [VC.navigationController popViewControllerAnimated:NO];
}
@end
