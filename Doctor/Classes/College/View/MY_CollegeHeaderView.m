//
//  MY_CollegeHeaderView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/27.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CollegeHeaderView.h"
#define TAG_FOR_BUTTON 2000
@implementation MY_CollegeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 100, 18)];
    titleLabel.text = @"选择课程";
    titleLabel.textColor = [MY_Util setColorWithInt:0x68d6a7];
    titleLabel.font = MY_Font(18);
    [self addSubview:titleLabel];
    
    NSArray *buttonTitles = [NSArray arrayWithObjects:@"医护技能",@"管理进修",@"科研试验",@"项目定制", nil];
    
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateHighlighted];
        [button setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 2;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
        button.titleLabel.font = MY_Font(13);
        button.tag = TAG_FOR_BUTTON + i + 1;
        
        CGFloat buttonW = 0;
        CGFloat space = 0;
        if (MY_Iphone4 | MY_Iphone5) {
            buttonW = 60;
        } else {
            buttonW = 70;
        }
        space = ((MY_ScreenWidth-30)-buttonW*4)/3;
        button.frame = CGRectMake(15 + (buttonW+space)*i, 50, buttonW, 25);
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)buttonAction:(UIButton*)btn {
    if (self.headerButtonBlock) {
        self.headerButtonBlock(btn.tag-TAG_FOR_BUTTON);
    }
}

@end
