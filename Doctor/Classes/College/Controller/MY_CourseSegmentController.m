//
//  MY_CourseSegmentController.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/1.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseSegmentController.h"
@interface MY_CourseSegmentController ()

@end

@implementation MY_CourseSegmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setTitle:@"医护技能" isBackButton:YES rightBttonName:nil rightImageName:nil];
    
    MY_TitleSegmentItem* item1=[[MY_TitleSegmentItem alloc] init];
    item1.title = @"全部";
    item1.index=0;
    
    MY_TitleSegmentItem* item2=[[MY_TitleSegmentItem alloc] init];
    item2.title = @"专科特训";
    item2.index=1;
    
    MY_TitleSegmentItem* item3=[[MY_TitleSegmentItem alloc] init];
    item3.title = @"医技培训";
    item3.index=2;
    
    MY_TitleSegmentItem* item4=[[MY_TitleSegmentItem alloc] init];
    item4.title = @"临床研修";
    item4.index=3;
    
    self.sgView=[[MY_TitleSegmentView alloc] initWithFrame:CGRectMake(0, MY_APP_STATUS_NAVBAR_HEIGHT, MY_ScreenWidth, 45) dataArray:@[item1,item2,item3,item4] delegate:self];
    self.segmentContentView.scrollView.backgroundColor = [UIColor purpleColor];
    [self.segmentView addSubview:self.sgView];
    
    [_sgView selectWithIndex:_currtentIndex];
}


-(void)didSelectWithIndex:(MY_TitleSegmentItem *)indexItem {
    [self setSelectedAt:indexItem.index];
}

-(void)setSegmentViewIndex:(NSInteger)index {
    [super setSegmentViewIndex:index];
    
    [self.sgView selectWithIndex:index];
}
@end
