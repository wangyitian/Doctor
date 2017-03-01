//
//  MY_EnrollView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_EnrollView.h"
@interface MY_EnrollView ()
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *companyTextField;
@property (nonatomic, strong) UITextView *needTextView;
@end
@implementation MY_EnrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor redColor];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    self.nameTextField = [[UITextField alloc] init];
    [self addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(nameLabel.mas_top);
        make.height.equalTo(nameLabel.mas_height);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    [self addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(nameLabel);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    [self addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameTextField);
        make.right.equalTo(self.nameTextField);
        make.top.equalTo(self.nameTextField.mas_bottom).with.offset(10);
        make.height.equalTo(self.nameTextField);
    }];
    
    UILabel *emailLabel = [[UILabel alloc] init];
    [self addSubview:emailLabel];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel);
        make.top.equalTo(phoneLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(phoneLabel);
    }];
    
    self.emailTextField = [[UITextField alloc] init];
    [self addSubview:self.emailTextField];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTextField);
        make.top.equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.size.mas_equalTo(self.phoneTextField);
    }];
    
    UILabel *companyLabel = [[UILabel alloc] init];
    [self addSubview:companyLabel];
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(emailLabel);
        make.top.equalTo(emailLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(emailLabel);
    }];
    
    self.companyTextField = [[UITextField alloc] init];
    [self addSubview:self.companyTextField];
    [self.companyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailTextField);
        make.top.equalTo(self.emailTextField.mas_bottom).with.offset(10);
        make.size.mas_equalTo(self.emailTextField);
    }];
    
    UILabel *needLabel = [[UILabel alloc] init];
    [self addSubview:needLabel];
    [needLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(companyLabel);
        make.top.equalTo(companyLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(companyLabel);
    }];
    
    self.needTextView = [[UITextView alloc] init];
    [self addSubview:self.needTextView];
    [self.needTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.companyTextField);
        make.top.equalTo(self.companyTextField.mas_bottom).with.offset(10);
        make.width.equalTo(self.companyTextField.mas_width);
        make.height.equalTo(@100);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.needTextView.mas_bottom).with.offset(50);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    
    [self layoutIfNeeded];
    self.height = confirmButton.bottom + 30;
    
}

@end
