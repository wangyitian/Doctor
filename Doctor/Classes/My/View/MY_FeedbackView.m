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
@property (nonatomic, strong) UITextView *suggestTextView;
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
    [self.phoneButton setTitle:@"400-882-3548" forState:UIControlStateNormal];
    [self.phoneButton setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
    self.phoneButton.titleLabel.font = MY_Font(15);
    self.phoneButton.layer.masksToBounds = YES;
    self.phoneButton.layer.cornerRadius = 2;
    self.phoneButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.phoneButton.layer.borderWidth = 1;
    [self.phoneButton addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.phoneButton];
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(18);
        make.right.equalTo(self).with.offset(-18);
        make.top.equalTo(self).with.offset(20);
        make.height.equalTo(@43);
    }];
    
    self.suggestTextView = [[UITextView alloc] init];
    self.suggestTextView.font = MY_Font(12);
    self.suggestTextView.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.suggestTextView.layer.borderWidth = 1;
    [self addSubview:self.suggestTextView];
    [self.suggestTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneButton.mas_bottom).with.offset(10);
        make.left.equalTo(self.phoneButton.mas_left);
        make.right.equalTo(self.phoneButton.mas_right);
        make.height.equalTo(@150);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.placeholder = @"请输入QQ号／手机号（必填）";
    self.phoneTextField.font = MY_Font(12);
    self.phoneTextField.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.phoneTextField.layer.borderWidth = 1;
    [self addSubview: self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.suggestTextView.mas_bottom).with.offset(10);
        make.left.equalTo(self.suggestTextView.mas_left);
        make.right.equalTo(self.suggestTextView.mas_right);
        make.height.equalTo(@44);
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
        make.top.equalTo(self.phoneTextField.mas_bottom).with.offset(20);
        make.left.equalTo(self.phoneTextField.mas_left);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.height.equalTo(@44);
    }];
    
    [self layoutIfNeeded];
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
