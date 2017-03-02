//
//  MY_ForgetPWDController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ForgetPWDController.h"
#import "MY_ChangePWDView.h"
@interface MY_ForgetPWDController ()

@end

@implementation MY_ForgetPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setTitle:@"注册" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    MY_ChangePWDView *registerView = [[MY_ChangePWDView alloc] initWithFrame:self.view.bounds];
    registerView.validateBlock = ^(NSString *account){
        
    };
    registerView.confirmBlock = ^(NSString *account, NSString *pwd, NSString *validate){
        
    };
    [self.scrollView addSubview:registerView];
}

@end
