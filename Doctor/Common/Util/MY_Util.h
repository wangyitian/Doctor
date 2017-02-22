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

/**
 *  用push的方式实现present的动画
 *
 *  @param fromVC 从哪个vc
 *  @param toVC   到哪个vc
 */
+ (void)pushAnimationFromVC:(UIViewController*)fromVC toVC:(UIViewController*)toVC;

/**
 *  把页面pop出去但是是用的present的动画
 *
 *  @param fromVC 从哪个vc开始
 *  @param toVC   到哪个vc结束
 */
+ (void)popAnimationFromVC:(UIViewController*)fromVC toVC:(UIViewController*)toVC;

@end
