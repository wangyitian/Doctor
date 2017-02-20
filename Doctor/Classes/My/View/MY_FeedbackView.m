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
    [self.phoneButton addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.phoneButton];
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(self).with.offset(10);
        make.height.equalTo(@35);
    }];
    
    self.suggestTextView = [[UITextView alloc] init];
    [self addSubview:self.suggestTextView];
    [self.suggestTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneButton.mas_bottom).with.offset(10);
        make.left.equalTo(self.phoneButton.mas_left);
        make.right.equalTo(self.phoneButton.mas_right);
        make.height.equalTo(@200);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    [self addSubview: self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.suggestTextView.mas_bottom).with.offset(10);
        make.left.equalTo(self.suggestTextView.mas_left);
        make.right.equalTo(self.suggestTextView.mas_right);
        make.height.equalTo(@35);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextField.mas_bottom).with.offset(50);
        make.left.equalTo(self.phoneTextField.mas_left);
        make.right.equalTo(self.phoneTextField.mas_right);
        make.height.equalTo(@35);
    }];
}

- (void)phoneButtonAction {
    
}

- (void)confirmButtonAction {
    if (self.confirmBlock) {
        self.confirmBlock(self.suggestTextView.text, self.phoneTextField.text);
    }
}

@end
