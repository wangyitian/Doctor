//
//  MY_PullController.h
//  Doctor
//
//  Created by 王翼天 on 2017/7/6.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseController.h"
#import "MY_LiveModel.h"
@interface MY_PullController : MY_BaseController
@property (nonatomic, strong) MY_LiveModel *model;
@property (nonatomic, assign) BOOL isLive;
@end
