//
//  MY_CourseSegmentController.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/1.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseSegmentController.h"
#import "MY_SelectView.h"
@interface MY_CourseSegmentController ()
@property (nonatomic, strong) MY_SelectView *selectedView;
@end

@implementation MY_CourseSegmentController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.typeIndex == 1) {
        [self setTitle:@"管理培训" isBackButton:YES rightBttonName:nil rightImageName:nil];
    } else if (self.typeIndex == 2) {
        [self setTitle:@"临床培训" isBackButton:YES rightBttonName:nil rightImageName:nil];
    } else if (self.typeIndex == 3) {
        [self setTitle:@"专题培训" isBackButton:YES rightBttonName:nil rightImageName:nil];
    } else if (self.typeIndex == 4) {
        [self setTitle:@"科研培训" isBackButton:YES rightBttonName:nil rightImageName:nil];
    }
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < self.types.count; i++) {
        MY_TitleSegmentItem* item = [[MY_TitleSegmentItem alloc] init];
        item.title = self.types[i];
        item.index = i;
        [dataArray addObject:item];
        item.typeArray = [NSArray arrayWithObjects:@"dsf",@"dsf",@"dsf", nil];
    }
    self.sgView=[[MY_TitleSegmentView alloc] initWithFrame:CGRectMake(0, MY_APP_STATUS_NAVBAR_HEIGHT, MY_ScreenWidth, 45) dataArray:dataArray delegate:self];
    self.segmentContentView.scrollView.backgroundColor = [UIColor purpleColor];
    [self.segmentView addSubview:self.sgView];
    
    [_sgView selectWithIndex:_currtentIndex];
}


-(void)didSelectWithIndex:(MY_TitleSegmentItem *)indexItem {
//    if (self.typeIndex == 1) {
//        if (indexItem.index != 0) {
//            if (!self.selectedView) {
//                self.selectedView = [[MY_SelectView alloc] initWithFrame:CGRectMake(0, MY_APP_STATUS_NAVBAR_HEIGHT + 45, MY_ScreenWidth, MY_ScreenHeight - 45 - MY_APP_STATUS_NAVBAR_HEIGHT)];
//            }
//            __block typeof(self) weakSelf = self;
//            self.selectedView.selectedBlock = ^(NSString *option) {
//                [weakSelf.selectedView removeFromSuperview];
//                [weakSelf setSelectedAt:indexItem.index];
//            };
//            self.selectedView.options = [NSArray arrayWithObjects:@"发生的",@"是否代购",@"的官方的",@"的说法是对方",@"说时代",@"三大纪律卡",@"福建卡雷拉斯",@"阿胶肯德基",@"啊摔",@"发的",@"蜂蜜水",@"房价疯狂",@"让方法",@"各分", nil];
//            [self.view addSubview:self.selectedView];
//        } else {
//            [self.selectedView removeFromSuperview];
//            [self setSelectedAt:indexItem.index];
//        }
//    } else {
//        [self setSelectedAt:indexItem.index];
//    }
    [self setSelectedAt:indexItem.index];
}

-(void)setSegmentViewIndex:(NSInteger)index {
//    [super setSegmentViewIndex:index];
    
    [self.sgView selectWithIndex:index];
}
@end
