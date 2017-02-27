//
//  MY_ForgetPWDView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/18.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ForgetPWDView.h"
@interface MY_ForgetPWDView ()
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *freshPwdTextField;
@property (nonatomic, strong) UITextField *confirmTextField;
@property (nonatomic, strong) UITextField *validateTextField;
@property (nonatomic, strong) UIButton *validateButton;
@end

@implementation MY_ForgetPWDView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor purpleColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.accountTextField = [[UITextField alloc] init];
    self.accountTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(100);
        make.left.equalTo(self).with.offset(30);
        make.right.equalTo(self).with.offset(-30);
        make.height.equalTo(@35);
    }];
    
    self.validateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.validateButton.backgroundColor = [UIColor redColor];
    [self.validateButton addTarget:self action:@selector(validateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.validateButton];
    [self.validateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.accountTextField.mas_right);
        make.top.equalTo(self.accountTextField.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 35));
    }];
    
    self.validateTextField = [[UITextField alloc] init];
    self.validateTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.validateTextField];
    [self.validateTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountTextField.mas_left);
        make.right.equalTo(self.validateButton.mas_left).with.offset(-10);
        make.top.equalTo(self.validateButton.mas_top);
        make.height.equalTo(self.validateButton.mas_height);
    }];
    
    self.freshPwdTextField = [[UITextField alloc] init];
    self.freshPwdTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.freshPwdTextField];
    [self.freshPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountTextField.mas_left);
        make.right.equalTo(self.accountTextField.mas_right);
        make.top.equalTo(self.validateTextField.mas_bottom).with.offset(10);
        make.height.equalTo(self.accountTextField.mas_height);
    }];
    
    self.confirmTextField = [[UITextField alloc] init];
    self.confirmTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.confirmTextField];
    [self.confirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountTextField.mas_left);
        make.right.equalTo(self.accountTextField.mas_right);
        make.top.equalTo(self.freshPwdTextField.mas_bottom).with.offset(10);
        make.height.equalTo(self.accountTextField.mas_height);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.backgroundColor = [UIColor redColor];
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.validateButton.mas_bottom).offset(100);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    
    [self layoutIfNeeded];
    self.height = confirmButton.bottom + 30;
}

- (void)validateButtonAction {
    if (self.validateBlock) {
        self.validateBlock(self.accountTextField.text);
    }
}

- (void)confirmButtonAction {
    if (self.confirmBlock) {
        self.confirmBlock(self.accountTextField.text, self.freshPwdTextField.text, self.confirmTextField.text, self.validateTextField.text);
    }
}
@end
