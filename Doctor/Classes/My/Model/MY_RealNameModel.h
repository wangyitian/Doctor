//
//  MY_RealNameModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/4/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_RealNameModel : MY_BaseModel
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isRequired;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *image;
@end
