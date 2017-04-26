//
//  MY_MyHeaderView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MyHeaderView.h"

@interface MY_MyHeaderView ()
@property (nonatomic, strong) UIButton *realNameButton;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton *personalDataButton;
//@property (nonatomic, strong) UIView *scheduleView;
@end

@implementation MY_MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.realNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.realNameButton.frame = CGRectMake(MY_ScreenWidth-20-70, 30, 70, 17);
    [self.realNameButton setTitle:@"实名认证" forState:UIControlStateNormal];
    [self.realNameButton setTitle:@"认证医生" forState:UIControlStateDisabled];
    [self.realNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.realNameButton.titleLabel.font = MY_Font(13);
    self.realNameButton.layer.masksToBounds = YES;
    self.realNameButton.layer.cornerRadius = 2;
    [self.realNameButton setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.realNameButton setBackgroundColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateDisabled];
    [self.realNameButton addTarget:self action:@selector(realNameButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.realNameButton];
    
    self.accountLabel = [[UILabel alloc] initWithFrame:CGRectMake((MY_ScreenWidth-200)/2, 30, 200, 17)];
    self.accountLabel.font = MY_Font(17);
    self.accountLabel.textColor = [MY_Util setColorWithInt:0x333333];
    self.accountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.accountLabel];
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MY_ScreenWidth-87)/2, self.accountLabel.bottom+12, 87, 87)];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 43.5;
    [self addSubview:self.avatarImageView];
    
    self.personalDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.personalDataButton.frame = CGRectMake(MY_ScreenWidth-100, self.avatarImageView.bottom-18, 100, 23);
    [self.personalDataButton setTitle:@"个人资料" forState:UIControlStateNormal];
    [self.personalDataButton setTitleColor:[MY_Util setColorWithInt:0x333333] forState:UIControlStateNormal];
    self.personalDataButton.titleLabel.font = MY_Font(13);
    [self.personalDataButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    self.personalDataButton.imageEdgeInsets = UIEdgeInsetsMake(6, 73, 6, 20);
    self.personalDataButton.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 27);
    [self.personalDataButton addTarget:self action:@selector(personalDataButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.personalDataButton];
    
    [self layoutIfNeeded];
    self.height = 160;
}

- (void)setObject:(id)object {
    MY_AccountModel *accountModel = (MY_AccountModel*)object;
    
    self.accountLabel.text = accountModel.nickname;
    
    self.realNameButton.enabled = accountModel.isConfirmed;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:accountModel.head] placeholderImage:[UIImage imageNamed:@"icon"]];
}

- (void)realNameButtonAction {
    if (self.realNameButton.enabled) {
        if (self.realNameBlock) {
            self.realNameBlock();
        }
    }
}

- (void)personalDataButtonAction {
    if (self.personalDataBlock) {
        self.personalDataBlock();
    }
}

@end
