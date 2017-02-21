//
//  MY_Util.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MY_AccountModel.h"
@interface MY_Util : NSObject
+ (void)saveAccount:(MY_AccountModel*)model;
+ (MY_AccountModel*)getAccountModel;
+ (void)removeAccount;
+ (BOOL)isLogin;


/**
 *  格式化日期
 *
 *  @param timestamp 时间戳
 *
 *  @return 2014.08.09这样的
 */
+ (NSString*)convertDate:(NSNumber*)timestamp;

+ (NSString*)convertDate:(NSNumber*)timestamp formatString:(NSString*)format;

+ (UIColor*)setColorWithInt: (int)newColor;
@end
