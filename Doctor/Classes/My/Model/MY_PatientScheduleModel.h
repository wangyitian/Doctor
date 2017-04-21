//
//  MY_PatientScheduleModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/4/19.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_PatientScheduleModel : MY_BaseModel
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, assign) BOOL  isFirst;
@property (nonatomic, assign) BOOL  isLast;
@end
