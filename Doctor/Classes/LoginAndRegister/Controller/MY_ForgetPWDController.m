//
//  MY_ForgetPWDController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ForgetPWDController.h"
#import "MY_ForgetPWDView.h"
@interface MY_ForgetPWDController ()

@end

@implementation MY_ForgetPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    MY_ForgetPWDView *forgetView = [[MY_ForgetPWDView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:forgetView];
}

@end
