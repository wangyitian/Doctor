//
//  MY_CourseModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/24.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_CourseModel : MY_BaseModel
@property (nonatomic, strong) NSString *courseId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *a_time;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *x_condition;
@property (nonatomic, strong) NSString *x_introduce;
@property (nonatomic, strong) NSString *x_brief;
@property (nonatomic, strong) NSString *file;
@end
