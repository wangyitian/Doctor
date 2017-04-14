//
//  MY_LoginView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/18.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_LoginView.h"
#import "MY_TabController.h"
@interface MY_LoginView ()
@property (nonatomic, strong) UITextField *accountTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@end

@implementation MY_LoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    logoImageView.frame = CGRectMake(0, 53, 115, 115);
    logoImageView.centerX = self.centerX;
    [self addSubview:logoImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, logoImageView.bottom+10, 300, 18)];
    titleLabel.centerX = self.centerX;
    titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    titleLabel.font = MY_Font(18);
    titleLabel.text = @"专业诊疗进修平台";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    self.accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(68, titleLabel.bottom+45, MY_ScreenWidth-68*2, 35)];
    self.accountTextField.placeholder = @"请输入手机号码";
    self.accountTextField.font = MY_Font(14);
    [self addSubview:self.accountTextField];
    
    UIView *accountLineView = [[UIView alloc] initWithFrame:CGRectMake(58, self.accountTextField.bottom, MY_ScreenWidth-58*2, 0.5)];
    accountLineView.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:accountLineView];
    
    self.pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.accountTextField.left, self.accountTextField.bottom+25, self.accountTextField.width, self.accountTextField.height)];
    self.pwdTextField.placeholder = @"请输入密码";
    self.pwdTextField.font = MY_Font(14);
    self.pwdTextField.secureTextEntry = YES;
    [self addSubview:self.pwdTextField];
    
    UIView *pwdLineView = [[UIView alloc] initWithFrame:CGRectMake(accountLineView.left, self.pwdTextField.bottom, accountLineView.width, accountLineView.height)];
    pwdLineView.backgroundColor = accountLineView.backgroundColor;
    [self addSubview:pwdLineView];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.frame = CGRectMake(pwdLineView.right-60, self.pwdTextField.bottom+5, 60, 23);
    forgetButton.titleLabel.font = MY_Font(13);
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgetButton];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(pwdLineView.left, forgetButton.bottom+45, pwdLineView.width, 44);
    loginButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 2;
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = MY_Font(15);
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginButton];

    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(accountLineView.left, loginButton.bottom+25, ((MY_ScreenWidth-58*2)-20)/2, 44);
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    registerButton.titleLabel.font = MY_Font(14);
    registerButton.layer.masksToBounds = YES;
    registerButton.layer.cornerRadius = 2;
    registerButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    registerButton.layer.borderWidth = 1;
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerButton];
    
    UIButton *tiyanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    tiyanButton.frame = CGRectMake(registerButton.right+20, registerButton.top, registerButton.width, registerButton.height);
    [tiyanButton setTitle:@"体验" forState:UIControlStateNormal];
    [tiyanButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    tiyanButton.titleLabel.font = MY_Font(14);
    tiyanButton.layer.masksToBounds = YES;
    tiyanButton.layer.cornerRadius = 2;
    tiyanButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    tiyanButton.layer.borderWidth = 1;
    [tiyanButton addTarget:self action:@selector(tiyanButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tiyanButton];
}

- (void)tiyanButtonAction {
    if (self.tiyanButtonBlock) {
        self.tiyanButtonBlock();
    }
}

- (void)forgetButtonAction {
    if (self.forgetButtonClick) {
        self.forgetButtonClick();
    }
}

- (void)loginButtonAction {
    if (self.accountTextField.text.length && self.pwdTextField.text.length) {
        if (self.loginButtonBlock) {
            self.loginButtonBlock(self.accountTextField.text, self.pwdTextField.text);
        }
    } else {
        [self alertWithMessage:@"请输入用户名或密码"];
    }
}

- (void)registerButtonAction {
    if (self.registerButtonClick) {
        self.registerButtonClick();
    }
}

@end
