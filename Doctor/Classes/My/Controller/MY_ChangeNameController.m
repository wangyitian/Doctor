//
//  MY_ChangeNameController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ChangeNameController.h"

@interface MY_ChangeNameController ()

@end

@implementation MY_ChangeNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"" isBackButton:YES rightBttonName:@"完成" rightImageName:nil];
    [self setupUI];
}

- (void)setupUI {
    UITextField *changeTextField = [[UITextField alloc] init];
    [self.view addSubview:changeTextField];
    [changeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(MY_APP_STATUS_NAVBAR_HEIGHT);
        make.height.equalTo(@35);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
    }];
}

- (void)rightButtonAction {
    
}

@end
