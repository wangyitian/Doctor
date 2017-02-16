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
+ (BOOL)isLogin;
@end
