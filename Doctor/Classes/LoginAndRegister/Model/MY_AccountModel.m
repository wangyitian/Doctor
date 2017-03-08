//
//  MY_AccountModel.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/16.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_AccountModel.h"

@implementation MY_AccountModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"uid" : @"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_phonen forKey:@"phonen"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _username = [aDecoder decodeObjectForKey:@"username"];
        _phonen = [aDecoder decodeObjectForKey:@"phonen"];
    }
    
    return self;
}
@end
