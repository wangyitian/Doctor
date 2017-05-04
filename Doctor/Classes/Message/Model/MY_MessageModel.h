//
//  MY_MessageModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/28.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_MessageModel : MY_BaseModel
@property (nonatomic, strong) NSString *data;
@property (nonatomic, strong) NSString *feedback;
@end
