//
//  MY_CourseCustomedController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseCustomedController.h"
#import "MY_CourseCustomedView.h"
@interface MY_CourseCustomedController ()

@end

@implementation MY_CourseCustomedController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
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
}

@end
