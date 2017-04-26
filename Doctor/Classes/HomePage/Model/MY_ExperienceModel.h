//
//  MY_ExperienceModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/4/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_ExperienceModel : MY_BaseModel
@property (nonatomic, strong) NSString *experienceId;
@property (nonatomic, strong) NSString *dianzan;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *experience;
@property (nonatomic, strong) NSString *project;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, assign) BOOL isOpen;
@end
