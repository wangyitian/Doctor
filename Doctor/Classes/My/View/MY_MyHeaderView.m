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
//@property (nonatomic, strong) UIButton *personalDataButton;
@property (nonatomic, strong) UIImageView *backView;
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
    CGFloat backViewHeight = 211*MY_ScreenWidth/375;
    self.backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, backViewHeight)];
    self.backView.image = [UIImage imageNamed:@"my_back"];
    self.backView.userInteractionEnabled = YES;
    [self addSubview:self.backView];
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, backViewHeight-20-87, 87, 87)];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 43.5;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.avatarImageView.clipsToBounds = YES;
    [self.backView addSubview:self.avatarImageView];
    
    self.accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.avatarImageView.right+15, 0, 200, 20)];
    self.accountLabel.centerY = self.avatarImageView.centerY;
    self.accountLabel.font = MY_Font(17);
    self.accountLabel.textColor = [UIColor whiteColor];
    [self.backView addSubview:self.accountLabel];
    
    self.realNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.realNameButton.frame = CGRectMake(self.accountLabel.left, self.accountLabel.bottom+10, 70, 17);
    [self.realNameButton setTitle:@"实名认证" forState:UIControlStateNormal];
    [self.realNameButton setTitle:@"已认证" forState:UIControlStateDisabled];
    [self.realNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.realNameButton.titleLabel.font = MY_Font(13);
    self.realNameButton.layer.masksToBounds = YES;
    self.realNameButton.layer.cornerRadius = 2;
    [self.realNameButton setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.realNameButton setBackgroundColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateDisabled];
    [self.realNameButton addTarget:self action:@selector(realNameButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.realNameButton];
    
    self.height = backViewHeight;
}

- (void)setObject:(id)object {
    MY_AccountModel *accountModel = (MY_AccountModel*)object;
    
    self.accountLabel.text = accountModel.nickname;
    
    self.realNameButton.enabled = (accountModel.type.integerValue != 1);
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:accountModel.head] placeholderImage:[UIImage imageNamed:@"icon"]];
}

- (void)realNameButtonAction {
    if (self.realNameButton.enabled) {
        if (self.realNameBlock) {
            self.realNameBlock();
        }
    }
}

@end
