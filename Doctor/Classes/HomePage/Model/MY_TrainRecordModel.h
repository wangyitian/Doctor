//
//  MY_TrainRecordModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/4/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_TrainRecordModel : MY_BaseModel
@property (nonatomic, strong) NSString *trainId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *abst;
@end
