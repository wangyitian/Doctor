//
//  MY_AccountModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/16.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MY_AccountModel : MY_BaseModel<NSCoding>
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *phonen;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *head;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *hospital;
@property (nonatomic, assign) BOOL isConfirmed;
@property (nonatomic, strong) NSString *card;
@property (nonatomic, strong) NSString *certificate;
@property (nonatomic, strong) NSString *title;
@end
