//
//  MY_LiveModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/7/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_LiveModel : MY_BaseModel
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) BOOL isLive;
@end
