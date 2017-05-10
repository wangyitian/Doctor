//
//  MY_CourseCustomedController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseCustomedController.h"
#import "MY_CourseCustomedView.h"
#import "MY_CustomedCourseModel.h"
#import "MY_CourseCustomedDemoCell.h"
@interface MY_CourseCustomedController ()
@property (nonatomic, weak) MY_CourseCustomedView *customedView;
@end

@implementation MY_CourseCustomedController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
//    [self falseData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UI
- (void)setupUI {
    [self setTitle:@"项目定制" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 50, 0);
    
    MY_CourseCustomedView *view = [[MY_CourseCustomedView alloc] initWithFrame:self.view.bounds];
    [self.scrollView addSubview:view];
    self.customedView = view;
}

- (void)falseData {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        MY_CustomedCourseModel *model = [[MY_CustomedCourseModel alloc] init];
        [array addObject:model];
    }
    NSDictionary *dic = @{@"models":array};
    self.customedView.dataDic = dic;
}

@end
