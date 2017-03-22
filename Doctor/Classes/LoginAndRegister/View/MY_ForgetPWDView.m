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
    self.accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 100, MY_ScreenWidth-30*2, 35)];
    self.accountTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.accountTextField];
    
    self.validateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.validateButton.frame = CGRectMake(MY_ScreenWidth-30-60, self.accountTextField.bottom+10, 60, 35);
    self.validateButton.backgroundColor = [UIColor redColor];
    [self.validateButton addTarget:self action:@selector(validateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.validateButton];
    
    self.validateTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.accountTextField.left, self.validateButton.top, self.validateButton.left-10-30, self.validateButton.height)];
    self.validateTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.validateTextField];
    
    self.freshPwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.accountTextField.left, self.validateTextField.bottom+10, self.accountTextField.width, self.accountTextField.height)];
    self.freshPwdTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.freshPwdTextField];
    
    self.confirmTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.accountTextField.left, self.freshPwdTextField.bottom+10, self.accountTextField.width, self.accountTextField.height)];
    self.confirmTextField.backgroundColor = [UIColor redColor];
    [self addSubview:self.confirmTextField];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(0, self.validateButton.bottom+100, 200, 35);
    confirmButton.backgroundColor = [UIColor redColor];
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];

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
