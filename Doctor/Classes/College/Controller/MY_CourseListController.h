//
//  MY_CourseListController.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseTableController.h"
@class MY_CourseSegmentController;
@interface MY_CourseListController : MY_BaseTableController
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *listType;
@property (nonatomic, weak) MY_CourseSegmentController *superVC;
@end
