//
//  MY_RecommendModel.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/18.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RecommendModel.h"

@implementation MY_RecommendModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"patientId" : @"id"};
}
@end
