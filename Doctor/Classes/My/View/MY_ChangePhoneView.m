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
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 88)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteView];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 64, 15)];
    phoneLabel.text = @"手机号码";
    phoneLabel.font = MY_Font(15);
    phoneLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self addSubview:phoneLabel];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(phoneLabel.right+10, 0, MY_ScreenWidth-phoneLabel.right-10, 30)];
    self.phoneTextField.centerY = phoneLabel.centerY;
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextField.placeholder = @"请输入手机号码";
    self.phoneTextField.font = MY_Font(12);
    [self addSubview:self.phoneTextField];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(6, 44, MY_ScreenWidth-6*2, 0.5)];
    line1.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:line1];
    
    UILabel *validateLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabel.left, line1.bottom+15, phoneLabel.width, phoneLabel.height)];
    validateLabel.text = @"验证码";
    validateLabel.font = MY_Font(15);
    validateLabel.textColor = phoneLabel.textColor;
    [self addSubview:validateLabel];
    
    self.validateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.validateButton.frame = CGRectMake(MY_ScreenWidth-30-80, 0, 80, 20);
    self.validateButton.centerY = validateLabel.centerY;
    [self.validateButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.validateButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    self.validateButton.titleLabel.font = MY_Font(12);
    self.validateButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.validateButton.layer.borderWidth = 1;
    [self.validateButton addTarget:self action:@selector(validateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.validateButton];
    
    self.validateTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.phoneTextField.left, 0, self.validateButton.left-self.phoneTextField.left, 30)];
    self.validateTextField.centerY = validateLabel.centerY;
    self.validateTextField.placeholder = @"请输入验证码";
    self.validateTextField.font = MY_Font(12);
    [self addSubview:self.validateTextField];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(18, self.validateTextField.bottom+20, MY_ScreenWidth-18*2, 44);
    [confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = MY_Font(15);
    confirmButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 2;
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
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
