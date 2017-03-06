//
//  MY_ScheduleModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/6.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_ScheduleModel : MY_BaseModel
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *time;
@end
