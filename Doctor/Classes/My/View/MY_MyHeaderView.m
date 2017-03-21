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
@property (nonatomic, strong) UIView *scheduleView;
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
    self.accountLabel = [[UILabel alloc] initWithFrame:CGRectMake((MY_ScreenWidth-200)/2, 30, 200, 17)];
    self.accountLabel.font = MY_Font(17);
    self.accountLabel.textColor = [MY_Util setColorWithInt:0x333333];
    self.accountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.accountLabel];
    
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MY_ScreenWidth-87)/2, self.accountLabel.bottom+12, 87, 87)];
    self.avatarImageView.image = [UIImage imageNamed:@"icon"];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 43.5;
    [self addSubview:self.avatarImageView];
    
    self.personalDataButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.personalDataButton.frame = CGRectMake(MY_ScreenWidth-100, self.avatarImageView.bottom-18, 100, 23);
    [self.personalDataButton setTitle:@"个人资料" forState:UIControlStateNormal];
    [self.personalDataButton setTitleColor:[MY_Util setColorWithInt:0x333333] forState:UIControlStateNormal];
    self.personalDataButton.titleLabel.font = MY_Font(13);
    [self.personalDataButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    self.personalDataButton.imageEdgeInsets = UIEdgeInsetsMake(8, 73, 8, 20);
    self.personalDataButton.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 27);
    [self.personalDataButton addTarget:self action:@selector(personalDataButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.personalDataButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 160, MY_ScreenWidth, 5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:line];
    
    UILabel *scheduleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, line.bottom+13, 100, 15)];
    scheduleLabel.text = @"服务进度";
    scheduleLabel.font = MY_Font(15);
    scheduleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self addSubview:scheduleLabel];
    
    UIButton *scheduleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [scheduleButton setTitle:@"详情" forState:UIControlStateNormal];
    [scheduleButton setTitleColor:[MY_Util setColorWithInt:0x333333] forState:UIControlStateNormal];
    scheduleButton.titleLabel.font = MY_Font(13);
    [scheduleButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    scheduleButton.imageEdgeInsets = UIEdgeInsetsMake(8, 46, 8, 20);
    scheduleButton.titleEdgeInsets = UIEdgeInsetsMake(5, 0, 5, 27);
    scheduleButton.frame = CGRectMake(MY_ScreenWidth-73, line.bottom+12, 73, 23);
    [scheduleButton addTarget:self action:@selector(scheduleButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:scheduleButton];
    
    self.scheduleView = [[UIView alloc] initWithFrame:CGRectMake(0, scheduleButton.bottom, MY_ScreenWidth, 75)];
    self.scheduleView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scheduleView];
    
    [self layoutIfNeeded];
    self.height = self.scheduleView.bottom;
}

- (void)setObject:(id)object {
    self.accountLabel.text = @"用户名";
    
    
    [self.scheduleView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray *schedules = [NSArray arrayWithObjects:@"邀请函",@"签合同",@"签证",@"机票",@"行监会", nil];
    
    for (int i = 0; i < schedules.count; i++) {
        CGFloat lineW = ((MY_ScreenWidth-34*2)-(5*9))/4;
        UIImageView *circle = [[UIImageView alloc] initWithFrame:CGRectMake(34+(lineW+9)*i, 27, 9, 9)];
        circle.image = [UIImage imageNamed:@"my_circle"];
        [self.scheduleView addSubview:circle];
        
        CGFloat labelW = [schedules[i] sizeWithAttributes:@{NSFontAttributeName:MY_Font(12)}].width;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, circle.bottom+10, labelW, 12)];
        label.centerX = circle.centerX;
        label.font = MY_Font(12);
        label.textColor = [MY_Util setColorWithInt:0x666666];
        label.text = schedules[i];
        [self.scheduleView addSubview:label];
        
        if (i == schedules.count-1) {
            break;
        }
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(circle.right, circle.top+4, lineW, 1)];
        lineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
        [self.scheduleView addSubview:lineView];
    }
    
}

- (void)scheduleButtonAction {
    if (self.scheduleBlock) {
        self.scheduleBlock();
    }
}

- (void)personalDataButtonAction {
    if (self.personalDataBlock) {
        self.personalDataBlock();
    }
}

@end
