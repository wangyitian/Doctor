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
    [aCoder encodeObject:_password forKey:@"password"];
    [aCoder encodeObject:_head forKey:@"head"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
    [aCoder encodeObject:_department forKey:@"department"];
    [aCoder encodeObject:_hospital forKey:@"hospital"];
    [aCoder encodeBool:_isConfirmed forKey:@"isConfirmed"];
    [aCoder encodeObject:_card forKey:@"card"];
    [aCoder encodeObject:_certificate forKey:@"certificate"];
    [aCoder encodeObject:_title forKey:@"title"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _username = [aDecoder decodeObjectForKey:@"username"];
        _phonen = [aDecoder decodeObjectForKey:@"phonen"];
        _password = [aDecoder decodeObjectForKey:@"password"];
        _head = [aDecoder decodeObjectForKey:@"head"];
        _nickname = [aDecoder decodeObjectForKey:@"nickname"];
        _department = [aDecoder decodeObjectForKey:@"department"];
        _hospital = [aDecoder decodeObjectForKey:@"hospital"];
        _isConfirmed = [aDecoder decodeBoolForKey:@"isConfirmed"];
        _card = [aDecoder decodeObjectForKey:@"card"];
        _certificate = [aDecoder decodeObjectForKey:@"certificate"];
        _title = [aDecoder decodeObjectForKey:@"title"];
        
    }
    
    return self;
}
@end
