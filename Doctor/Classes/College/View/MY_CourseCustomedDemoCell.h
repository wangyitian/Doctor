//
//  MY_CourseCustomedDemoCell.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseCell.h"

typedef void (^IsOpenBlock)(NSIndexPath *indexPath, BOOL isOpen);
@interface MY_CourseCustomedDemoCell : MY_BaseCell
@property (nonatomic, copy) IsOpenBlock isOpenBlock;
@end
