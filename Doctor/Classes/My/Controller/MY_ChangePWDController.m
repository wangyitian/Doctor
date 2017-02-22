//
//  MY_ChangePWDController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ChangePWDController.h"
#import "MY_ChangePWDView.h"
@interface MY_ChangePWDController ()

@end

@implementation MY_ChangePWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"修改密码" isBackButton:YES rightBttonName:nil rightImageName:nil];
    
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_NAVBAR_HEIGHT, 0, 0, 0);
    [self setupUI];
}

- (void)setupUI {
    MY_ChangePWDView *changePwdView = [[MY_ChangePWDView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    [self.scrollView addSubview:changePwdView];
}

@end
