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
    [self addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(53);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(115, 115));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    titleLabel.font = MY_Font(18);
    titleLabel.text = @"专业诊疗进修平台";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(logoImageView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(300, 18));
    }];
    
    self.accountTextField = [[UITextField alloc] init];
    self.accountTextField.placeholder = @"请输入手机号码";
    self.accountTextField.font = MY_Font(14);
    [self addSubview:self.accountTextField];
    [self.accountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@68);
        make.top.equalTo(titleLabel.mas_bottom).with.offset(45);
        make.height.equalTo(@35);
        make.right.equalTo(self).with.offset(-68);
    }];
    
    UIView *accountLineView = [[UIView alloc] init];
    accountLineView.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:accountLineView];
    [accountLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@58);
        make.right.mas_equalTo(self).with.offset(-58);
        make.top.mas_equalTo(self.accountTextField.mas_bottom);
        make.height.mas_equalTo(@0.5);
    }];
    
    self.pwdTextField = [[UITextField alloc] init];
    self.pwdTextField.placeholder = @"请输入密码";
    self.pwdTextField.font = MY_Font(14);
    self.pwdTextField.secureTextEntry = YES;
    [self addSubview:self.pwdTextField];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountTextField.mas_left);
        make.height.equalTo(self.accountTextField.mas_height);
        make.top.equalTo(self.accountTextField.mas_bottom).with.offset(25);
        make.right.equalTo(self.accountTextField.mas_right);
    }];
    
    UIView *pwdLineView = [[UIView alloc] init];
    pwdLineView.backgroundColor = accountLineView.backgroundColor;
    [self addSubview:pwdLineView];
    [pwdLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(accountLineView);
        make.top.mas_equalTo(self.pwdTextField.mas_bottom);
        make.size.mas_equalTo(accountLineView);
    }];
    
    UIButton *forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetButton.titleLabel.font = MY_Font(13);
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgetButton];
    [forgetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pwdTextField.mas_bottom).with.offset(5);
        make.right.equalTo(pwdLineView.mas_right);
        make.size.mas_equalTo(CGSizeMake(60, 23));
    }];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    loginButton.layer.masksToBounds = YES;
    loginButton.layer.cornerRadius = 2;
    [loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginButton.titleLabel.font = MY_Font(15);
    [loginButton addTarget:self action:@selector(loginButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pwdLineView);
        make.top.equalTo(forgetButton.mas_bottom).with.offset(45);
        make.right.mas_equalTo(pwdLineView);
        make.height.mas_equalTo(@44);
    }];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    registerButton.titleLabel.font = MY_Font(14);
    registerButton.layer.masksToBounds = YES;
    registerButton.layer.cornerRadius = 2;
    registerButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    registerButton.layer.borderWidth = 1;
    [registerButton addTarget:self action:@selector(registerButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountLineView);
        make.top.equalTo(loginButton.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(((MY_ScreenWidth-58*2)-20)/2, 44));
    }];
    
    UIButton *tiyanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tiyanButton setTitle:@"体验" forState:UIControlStateNormal];
    [tiyanButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    tiyanButton.titleLabel.font = MY_Font(14);
    tiyanButton.layer.masksToBounds = YES;
    tiyanButton.layer.cornerRadius = 2;
    tiyanButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    tiyanButton.layer.borderWidth = 1;
    [tiyanButton addTarget:self action:@selector(tiyanButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tiyanButton];
    [tiyanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(registerButton.mas_right).with.offset(20);
        make.top.mas_equalTo(registerButton);
        make.size.mas_equalTo(registerButton);
    }];
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
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入用户名或密码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
    }
}

- (void)registerButtonAction {
    if (self.registerButtonClick) {
        self.registerButtonClick();
    }
}

@end
