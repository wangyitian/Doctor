//
//  MY_ChangePWDView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/22.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ChangePWDView.h"
@interface MY_ChangePWDView ()
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *validateTextField;
@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UITextField *confirmTextField;
@end
@implementation MY_ChangePWDView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(@5);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"手机号码";
    phoneLabel.font = MY_Font(15);
    phoneLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@20);
        make.top.mas_equalTo(topView.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(64, 15));
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextField.placeholder = @"请输入手机号码";
    self.phoneTextField.font = MY_Font(12);
    [self addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel.mas_right).with.offset(10);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(@30);
        make.centerY.mas_equalTo(phoneLabel);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@6);
        make.right.mas_equalTo(self).with.offset(-6);
        make.height.mas_equalTo(@0.5);
        make.top.mas_equalTo(topView.mas_bottom).with.offset(44);
    }];
    
    UILabel *validateLabel = [[UILabel alloc] init];
    validateLabel.text = @"验证码";
    validateLabel.font = MY_Font(15);
    validateLabel.textColor = phoneLabel.textColor;
    [self addSubview:validateLabel];
    [validateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel);
        make.top.mas_equalTo(line1.mas_bottom).with.offset(15);
        make.size.mas_equalTo(phoneLabel);
    }];
    
    self.validateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.validateButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.validateButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    self.validateButton.titleLabel.font = MY_Font(12);
    self.validateButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.validateButton.layer.borderWidth = 1;
    [self.validateButton addTarget:self action:@selector(validateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.validateButton];
    [self.validateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.centerY.mas_equalTo(validateLabel);
        make.right.mas_equalTo(self).with.offset(-30);
    }];
    
    self.validateTextField = [[UITextField alloc] init];
    self.validateTextField.placeholder = @"请输入验证码";
    self.validateTextField.font = MY_Font(12);
    [self addSubview:self.validateTextField];
    [self.validateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTextField);
        make.right.mas_equalTo(self.validateButton.mas_left);
        make.centerY.mas_equalTo(validateLabel);
        make.height.mas_equalTo(self.phoneTextField);
    }];
    
    UIView *middleView = [[UIView alloc] init];
    middleView.backgroundColor = topView.backgroundColor;
    [self addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView);
        make.top.mas_equalTo(line1.mas_bottom).with.offset(44);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 10));
    }];
    
    UILabel *freshPwd = [[UILabel alloc] init];
    freshPwd.textColor = validateLabel.textColor;
    freshPwd.font = validateLabel.font;
    freshPwd.text = @"新密码";
    [self addSubview:freshPwd];
    [freshPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(validateLabel);
        make.left.mas_equalTo(validateLabel);
        make.top.mas_equalTo(middleView.mas_bottom).with.offset(15);
    }];
    
    self.pwdTextField = [[UITextField alloc] init];
    self.pwdTextField.placeholder = @"请输入密码(6-16位数字或字母)";
    self.pwdTextField.secureTextEntry = YES;
    self.pwdTextField.font = MY_Font(12);
    [self addSubview:self.pwdTextField];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTextField);
        make.size.mas_equalTo(self.phoneTextField);
        make.centerY.mas_equalTo(freshPwd);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = line1.backgroundColor;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1);
        make.size.mas_equalTo(line1);
        make.top.mas_equalTo(middleView.mas_bottom).with.offset(44);
    }];
    
    UILabel *confirmLabel = [[UILabel alloc] init];
    confirmLabel.textColor = freshPwd.textColor;
    confirmLabel.font = freshPwd.font;
    confirmLabel.text = @"确认密码";
    [self addSubview:confirmLabel];
    [confirmLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(freshPwd);
        make.top.mas_equalTo(line2.mas_bottom).with.offset(15);
        make.size.mas_equalTo(freshPwd);
    }];
    
    self.confirmTextField = [[UITextField alloc] init];
    self.confirmTextField.placeholder = @"请再次输入密码(6-16位数字或字母)";
    self.confirmTextField.secureTextEntry = YES;
    self.confirmTextField.font = MY_Font(12);
    [self addSubview:self.confirmTextField];
    [self.confirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pwdTextField);
        make.centerY.mas_equalTo(confirmLabel);
        make.size.mas_equalTo(self.pwdTextField);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = middleView.backgroundColor;
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(middleView);
        make.top.mas_equalTo(line2.mas_bottom).with.offset(44);
        make.size.mas_equalTo(middleView);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = MY_Font(15);
    confirmButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 2;
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@18);
        make.right.mas_equalTo(self).with.offset(-18);
        make.top.mas_equalTo(bottomView.mas_bottom).with.offset(20);
        make.height.mas_equalTo(44);
    }];
    
    [self layoutIfNeeded];
    self.height = confirmButton.bottom + 30;
}

- (void)validateButtonAction {
    [self endEditing:YES];
    if ([self.phoneTextField.text isPhoneNum]) {
        if (self.validateBlock) {
            self.validateBlock(self.phoneTextField.text);
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入正确的手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
    }
}

- (void)confirmButtonAction {
    if (self.phoneTextField.text.length && self.validateTextField.text.length && self.pwdTextField.text.length && self.confirmTextField.text.length) {
        if ([self.pwdTextField.text isEqualToString:self.confirmTextField.text]) {
            if (self.confirmBlock) {
                self.confirmBlock(self.phoneTextField.text, self.validateTextField.text, self.pwdTextField.text);
            }
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"两次输入密码不一致，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
            [[self findController] presentViewController:alert animated:YES completion:nil];
        }
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"您填写的信息不完整，请填写完整后再试" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
    }
    
}

@end
