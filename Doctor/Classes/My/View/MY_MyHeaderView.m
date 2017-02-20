//
//  MY_MyHeaderView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MyHeaderView.h"

@interface MY_MyHeaderView ()
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton *personalDataButton;
@end

@implementation MY_MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor purpleColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.accountLabel = [[UILabel alloc] init];
    self.accountLabel.backgroundColor = [UIColor redColor];
    [self addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.backgroundColor = [UIColor redColor];
    [self addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountLabel.mas_bottom).with.offset(5);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    self.personalDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.personalDataButton.backgroundColor = [UIColor redColor];
    [self.personalDataButton addTarget:self action:@selector(personalDataButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.personalDataButton];
    [self.personalDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.bottom.equalTo(self.avatarImageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
    [self layoutIfNeeded];
    self.height = self.personalDataButton.bottom + 30;
}

- (void)personalDataButtonAction {
    if (self.personalDataBlock) {
        self.personalDataBlock();
    }
}

@end
