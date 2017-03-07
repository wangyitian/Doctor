//
//  MY_CourseModel.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/24.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseModel.h"

@interface MY_CourseModel : MY_BaseModel
@property (nonatomic, strong) NSString *courseImage;
@property (nonatomic, strong) NSString *courseTitle;
@property (nonatomic, strong) NSString *courseRoomType;
@property (nonatomic, strong) NSArray *detailArray;
@end
