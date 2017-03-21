//
//  MY_FeedbackView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_FeedbackView.h"
@interface MY_FeedbackView ()
@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) MY_TextView *suggestTextView;
@property (nonatomic, strong) UITextField *phoneTextField;
@end
@implementation MY_FeedbackView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.phoneButton.frame = CGRectMake(18, 20, MY_ScreenWidth-18*2, 43);
    [self.phoneButton setTitle:@"400-882-3548" forState:UIControlStateNormal];
    [self.phoneButton setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
    self.phoneButton.titleLabel.font = MY_Font(15);
    self.phoneButton.layer.masksToBounds = YES;
    self.phoneButton.layer.cornerRadius = 2;
    self.phoneButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.phoneButton.layer.borderWidth = 1;
    [self.phoneButton addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.phoneButton];
    
    self.suggestTextView = [[MY_TextView alloc] initWithFrame:CGRectMake(self.phoneButton.left, self.phoneButton.bottom+10, self.phoneButton.width, 150)];
    self.suggestTextView.font = MY_Font(12);
    self.suggestTextView.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.suggestTextView.layer.borderWidth = 1;
    self.suggestTextView.myPlaceholder = @" 请输入您对我们的意见和建议...(200字以内)";
    [self addSubview:self.suggestTextView];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.suggestTextView.left, self.suggestTextView.bottom+10, self.suggestTextView.width, 44)];
    self.phoneTextField.placeholder = @"请输入QQ号／手机号（必填）";
    self.phoneTextField.font = MY_Font(12);
    self.phoneTextField.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTextField.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.phoneTextField.layer.borderWidth = 1;
    [self addSubview: self.phoneTextField];
    self.phoneTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 44)];
    self.phoneTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(self.phoneTextField.left, self.phoneTextField.bottom+20, self.phoneTextField.width, 44);
    [confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = MY_Font(15);
    confirmButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 2;
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];

    self.height = confirmButton.bottom + 30;
}

- (void)phoneButtonAction {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.phoneButton.titleLabel.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
}

- (void)confirmButtonAction {
    if (self.confirmBlock) {
        self.confirmBlock(self.suggestTextView.text, self.phoneTextField.text);
    }
}

@end
