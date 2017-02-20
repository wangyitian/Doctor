//
//  MY_LoginView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/18.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_LoginView.h"
@interface MY_LoginView ()
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@end

@implementation MY_LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor purpleColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    logoImageView.backgroundColor = [UIColor redColor];
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(100);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    UIImageView *accountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    accountImageView.backgroundColor = [UIColor redColor];
    [self addSubview:accountImageView];
    [accountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(30);
        make.top.equalTo(logoImageView.mas_bottom).with.offset(100);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    pwdImageView.backgroundColor = [UIColor redColor];
    [self addSubview:pwdImageView];
    [pwdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(30);
        make.top.equalTo(accountImageView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    self.accountTextField = [[UITextField alloc] init];
    self.accountTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountImageView.mas_right).with.offset(20);
        make.top.equalTo(accountImageView.mas_top);
        make.height.equalTo(accountImageView.mas_height);
        make.right.equalTo(self).with.offset(-50);
    }];
    
    self.pwdTextField = [[UITextField alloc] init];
    self.pwdTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.pwdTextField];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountTextField.mas_left);
        make.height.equalTo(self.accountTextField.mas_height);
        make.top.equalTo(pwdImageView.mas_top);
        make.right.equalTo(self.accountTextField.mas_right);
    }];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.backgroundColor = [UIColor redColor];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgetButton];
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom).with.offset(5);
        make.right.equalTo(self.pwdTextField.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [UIColor redColor];
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdImageView.mas_left);
        make.top.equalTo(forgetButton.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.backgroundColor = [UIColor redColor];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pwdTextField.mas_right);
        make.top.equalTo(loginButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    [self layoutIfNeeded];
    NSLog(@"register=%@",NSStringFromCGRect(registerButton.frame));
    self.height = registerButton.bottom+30;
}

- (void)forgetButtonAction {
    if (self.forgetButtonClick) {
        self.forgetButtonClick();
    }
}

- (void)loginButtonAction {
    if (self.loginButtonBlock) {
        self.loginButtonBlock(self.accountTextField.text, self.pwdTextField.text);
    }
}

- (void)registerButtonAction {
    if (self.registerButtonClick) {
        self.registerButtonClick();
    }
}

@end
