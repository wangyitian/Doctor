//
//  MY_ChangePhoneView.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/2.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ChangePhoneView.h"

@implementation MY_ChangePhoneView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *whiteView = [[UIView alloc] init];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(@0);
        make.height.mas_equalTo(@88);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"手机号码";
    phoneLabel.font = MY_Font(15);
    phoneLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@20);
        make.top.mas_equalTo(@15);
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
        make.top.mas_equalTo(@44);
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
        make.top.mas_equalTo(self.validateTextField.mas_bottom).with.offset(20);
        make.height.mas_equalTo(44);
    }];
}

- (void)timerFire {
    self.validateButton.enabled = NO;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    [self.timer fire];
}
- (void)timer:(NSTimer*)timer {
    
    static NSInteger second = 60;
    second--;
    [self.validateButton setTitle:[NSString stringWithFormat:@"%ld秒后重试",(long)second] forState:UIControlStateDisabled];
    
    if (second == 0) {
        self.validateButton.enabled = YES;
        second = 60;
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)validateButtonAction {
    if (self.validateBlcok) {
        self.validateBlcok(self.phoneTextField.text);
    }
}

- (void)confirmButtonAction {
    if (self.confirmBlock) {
        self.confirmBlock(self.phoneTextField.text, self.validateTextField.text);
    }
}

@end
