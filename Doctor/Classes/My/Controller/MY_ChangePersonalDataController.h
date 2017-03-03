//
//  MY_ChangeNameController.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseController.h"

typedef enum : NSUInteger {
    Change_NickName,
    Change_RealName,
    Change_Hospital
} ChangePersonalData;

@interface MY_ChangePersonalDataController : MY_BaseController
@property (nonatomic, assign) ChangePersonalData changeType;
@end
