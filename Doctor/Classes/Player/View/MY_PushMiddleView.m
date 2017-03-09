//
//  MY_PushMiddleView.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PushMiddleView.h"
@interface MY_PushMiddleView ()

@end
@implementation MY_PushMiddleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleTextField = [[UITextField alloc] init];
    self.titleTextField.textAlignment = NSTextAlignmentCenter;
    self.titleTextField.font = MY_Font(18);
    self.titleTextField.placeholder = @"给直播起个标题吧";
    [self.titleTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.titleTextField becomeFirstResponder];
    [self addSubview:self.titleTextField];
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(@30);
        make.size.mas_equalTo(CGSizeMake(180, 22));
    }];
    
    self.liveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.liveButton setTitle:@"开始直播" forState:UIControlStateNormal];
    [self.liveButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    self.liveButton.titleLabel.font = MY_Font(15);
    self.liveButton.layer.masksToBounds = YES;
    self.liveButton.layer.cornerRadius = 22;
    self.liveButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.liveButton.layer.borderWidth = 1;
    [self.liveButton addTarget:self action:@selector(liveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.liveButton];
    [self.liveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.titleTextField.mas_bottom).with.offset(60);
        make.size.mas_equalTo(CGSizeMake(120, 44));
    }];
}

- (void)liveButtonAction {
    if (self.liveButtonBlock) {
        self.liveButtonBlock();
    }
}

@end