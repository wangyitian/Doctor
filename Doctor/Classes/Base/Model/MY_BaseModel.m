//
//  MY_BaseModel.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"
#import "YYModel.h"
@implementation MY_BaseModel
- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        [self yy_modelSetWithJSON:dic];
    }
    return self;
}

@end
