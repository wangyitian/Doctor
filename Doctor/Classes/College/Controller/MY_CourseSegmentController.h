//
//  MY_CourseSegmentController.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/1.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_SegmentController.h"
#import "MY_TitleSegmentView.h"
@interface MY_CourseSegmentController : MY_SegmentController<MY_TitleSegmentDelegate>
@property(nonatomic,strong)MY_TitleSegmentView* sgView;
@property(nonatomic,assign)NSInteger currtentIndex;
@property (nonatomic, assign) NSInteger typeIndex;
@property (nonatomic, strong) NSArray *types;
@end
