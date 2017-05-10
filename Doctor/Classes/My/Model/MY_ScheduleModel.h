//
//  MY_ScheduleModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/6.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_ScheduleModel : MY_BaseModel
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *feedback;
@property (nonatomic, assign) BOOL  isFirst;
@property (nonatomic, assign) BOOL  isLast;
@end
