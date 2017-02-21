//
//  MY_RecommendView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RecommendView.h"
@interface MY_RecommendView ()
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) NSArray *patientButtons;
@property (nonatomic, strong) UIButton *sickTypeButton;
@property (nonatomic, strong) UITextView *sickTextView;
@property (nonatomic, strong) NSArray *agreeButtons;
@end
@implementation MY_RecommendView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@10);
        make.left.mas_equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    self.nameTextField = [[UITextField alloc] init];
    [self addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right).with.offset(10);
        make.top.mas_equalTo(nameLabel);
        make.height.mas_equalTo(@30);
        make.right.mas_equalTo(self).with.offset(-10);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    [self addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(nameLabel);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    [self addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTextField);
        make.top.mas_equalTo(self.nameTextField.mas_bottom).with.offset(10);
        make.size.mas_equalTo(self.nameTextField);
    }];
    
    UIButton *patientButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:patientButton];
    [patientButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTextField);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    UIButton *familyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:familyButton];
    [familyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(patientButton);
        make.right.mas_equalTo(self.phoneTextField);
        make.size.mas_equalTo(patientButton);
    }];
    self.patientButtons = [NSArray arrayWithObjects:patientButton, familyButton, nil];
    
    UILabel *sickTypeLabel = [[UILabel alloc] init];
    [self addSubview:sickTypeLabel];
    [sickTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel);
        make.top.mas_equalTo(patientButton.mas_bottom).with.offset(10);
        make.size.mas_equalTo(phoneLabel);
    }];
    
    self.sickTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.sickTypeButton];
    [self.sickTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTextField);
        make.top.mas_equalTo(patientButton.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    UILabel *sickLabel = [[UILabel alloc] init];
    [self addSubview:sickLabel];
    [sickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sickTypeLabel);
        make.top.mas_equalTo(sickTypeLabel.mas_bottom).with.offset(10);
        make.size.mas_equalTo(sickTypeLabel);
    }];
    
    self.sickTextView = [[UITextView alloc] init];
    [self addSubview:self.sickTextView];
    [self.sickTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.phoneTextField);
        make.top.mas_equalTo(self.sickTypeButton.mas_bottom).with.offset(10);
        make.right.mas_equalTo(self.phoneTextField);
        make.height.mas_equalTo(@100);
    }];
    
    UILabel *agreeLabel = [[UILabel alloc] init];
    [self addSubview:agreeLabel];
    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sickLabel);
        make.top.mas_equalTo(self.sickTextView.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    UIButton *agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:agreeButton];
    
    UIButton *noAgreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:noAgreeButton];
    self.agreeButtons = [NSArray arrayWithObjects:agreeButton,noAgreeButton, nil];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:confirmButton];
    
    [self layoutIfNeeded];
    self.height = agreeLabel.bottom + 30;
}

@end
