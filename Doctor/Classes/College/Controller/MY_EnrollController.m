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
    [self setTitle:@"报名参加" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    MY_EnrollView *enrollView = [[MY_EnrollView alloc] initWithFrame:self.view.bounds];
    enrollView.confirmBlock = ^(NSDictionary *paramter) {
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        [model postDataWithURL:MY_API_ENROLL paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            
        }];
    };
    [self.scrollView addSubview:enrollView];
    self.scrollView.contentSize = CGSizeMake(MY_ScreenWidth, enrollView.height);
}

@end
