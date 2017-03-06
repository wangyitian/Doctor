//
//  MY_ChangePhoneController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ChangePhoneController.h"
#import "MY_ChangePhoneView.h"
@interface MY_ChangePhoneController ()

@end

@implementation MY_ChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    [self setTitle:@"修改手机号" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    
    MY_ChangePhoneView *view = [[MY_ChangePhoneView alloc] initWithFrame:self.view.bounds];
    [self.scrollView addSubview:view];
}

@end
