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
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    if(self.changeType == Change_NickName) {
        [self setTitle:@"修改昵称" isBackButton:YES rightBttonName:@"完成" rightImageName:nil];
    } else if (self.changeType == Change_RealName) {
        [self setTitle:@"修改姓名" isBackButton:YES rightBttonName:@"完成" rightImageName:nil];
    } else if (self.changeType == Change_Hospital) {
        [self setTitle:@"修改医院" isBackButton:YES rightBttonName:@"完成" rightImageName:nil];
    }
    UITextField *changeTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, MY_APP_STATUS_NAVBAR_HEIGHT, MY_ScreenWidth, 44)];
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
    self.changeTextField = changeTextField;
}

#pragma mark - 完成按钮点击事件
- (void)rightButtonAction {
    
    if (self.changeTextField.text.length) {
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
        if (self.changeType == Change_NickName) {
            [paramter setObject:self.changeTextField.text forKey:@"nickname"];
        } else if (self.changeType == Change_RealName) {
            [paramter setObject:self.changeTextField.text forKey:@"username"];
        } else if (self.changeType == Change_Hospital) {
            [paramter setObject:self.changeTextField.text forKey:@"hospital"];
        }
        [model postDataWithURL:MY_API_CHANGE_PERSONAL_DATA paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            
        }];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"输入不能为空" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
