//
//  MY_EnrollController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_EnrollController.h"
#import "MY_EnrollView.h"
@interface MY_EnrollController ()

@end

@implementation MY_EnrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)setupUI {
    [self setTitle:@"报名参加" isBackButton:YES rightBttonName:nil rightImageName:nil];
    
    MY_EnrollView *enrollView = [[MY_EnrollView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    [self.scrollView addSubview:enrollView];
}

@end
