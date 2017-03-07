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
    if (self.typeIndex == 1) {
        [self setTitle:@"医护技能" isBackButton:YES rightBttonName:nil rightImageName:nil];
    } else if (self.typeIndex == 2) {
        [self setTitle:@"管理进修" isBackButton:YES rightBttonName:nil rightImageName:nil];
    } else if (self.typeIndex == 3) {
        [self setTitle:@"科研试验" isBackButton:YES rightBttonName:nil rightImageName:nil];
    }
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < self.types.count; i++) {
        MY_TitleSegmentItem* item = [[MY_TitleSegmentItem alloc] init];
        item.title = self.types[i];
        item.index = i + 1;
        [dataArray addObject:item];
        item.typeArray = [NSArray arrayWithObjects:@"dsf",@"dsf",@"dsf", nil];
    }
    self.sgView=[[MY_TitleSegmentView alloc] initWithFrame:CGRectMake(0, MY_APP_STATUS_NAVBAR_HEIGHT, MY_ScreenWidth, 45) dataArray:dataArray delegate:self];
    self.segmentContentView.scrollView.backgroundColor = [UIColor purpleColor];
    [self.segmentView addSubview:self.sgView];
    
    [_sgView selectWithIndex:_currtentIndex];
}


-(void)didSelectWithIndex:(MY_TitleSegmentItem *)indexItem {
    if (self.typeIndex == 1) {
//        if (indexItem.index != 1) {
//            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, MY_APP_STATUS_NAVBAR_HEIGHT + 45, MY_ScreenWidth, MY_ScreenHeight - 45 - MY_APP_STATUS_NAVBAR_HEIGHT - 100)];
//            view.backgroundColor = [UIColor blueColor];
//            [self.view addSubview:view];
//        }
    } else {
        [self setSelectedAt:indexItem.index];
    }
}

-(void)setSegmentViewIndex:(NSInteger)index {
//    [super setSegmentViewIndex:index];
    
    [self.sgView selectWithIndex:index];
}
@end
