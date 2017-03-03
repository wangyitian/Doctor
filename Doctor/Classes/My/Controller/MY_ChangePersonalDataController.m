//
//  MY_ChangeNameController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ChangePersonalDataController.h"

@interface MY_ChangePersonalDataController ()
@property (nonatomic, weak) UITextField *changeTextField;
@end

@implementation MY_ChangePersonalDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    if(self.changeType == Change_NickName) {
        [self setTitle:@"修改昵称" isBackButton:YES rightBttonName:@"完成" rightImageName:nil];
    } else if (self.changeType == Change_RealName) {
        [self setTitle:@"修改姓名" isBackButton:YES rightBttonName:@"完成" rightImageName:nil];
    } else if (self.changeType == Change_Hospital) {
        [self setTitle:@"修改医院" isBackButton:YES rightBttonName:@"完成" rightImageName:nil];
    }
    UITextField *changeTextField = [[UITextField alloc] init];
    changeTextField.backgroundColor = [UIColor whiteColor];
    changeTextField.font = MY_Font(15);
    changeTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    changeTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:changeTextField];
    if(self.changeType == Change_NickName) {
        changeTextField.placeholder = @"请输入昵称";
    } else if (self.changeType == Change_RealName) {
        changeTextField.placeholder = @"请输入姓名";
    } else if (self.changeType == Change_Hospital) {
        changeTextField.placeholder = @"请输入医院名";
    }
    [changeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(MY_APP_STATUS_NAVBAR_HEIGHT);
        make.height.equalTo(@44);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
    }];
    self.changeTextField = changeTextField;
}

- (void)rightButtonAction {
    
}

@end
