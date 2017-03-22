//
//  MY_HomePageHeaderView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/27.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_HomePageHeaderView.h"
#import "SDCycleScrollView.h"
#define TAG_FOR_BUTTON  2000
@interface MY_HomePageHeaderView ()
@property (nonatomic, strong) SDCycleScrollView *imageScrollView;
@property (nonatomic, strong) UIView *buttonView;
@end
@implementation MY_HomePageHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.imageScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 140*MY_ScreenWidth/375)];
    self.imageScrollView.backgroundColor = [UIColor redColor];
    [self addSubview:self.imageScrollView];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageScrollView.bottom, MY_ScreenWidth, 100)];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.buttonView];
    
    NSArray *buttonTitles = [NSArray arrayWithObjects:@"医护技能",@"管理进修",@"科研试验",@"项目定制", nil];
    NSArray *buttonImages = [NSArray arrayWithObjects:@"homePage_button1",@"homePage_button2",@"homePage_button3",@"homePage_button4", nil];
    CGFloat buttonW = 44;
    CGFloat buttonH = 44;
    CGFloat buttonY = 20;
    CGFloat space = (MY_ScreenWidth-buttonW*buttonTitles.count-30*2)/(buttonTitles.count-1);
    for (int i = 0; i < buttonTitles.count; i++) {
        CGFloat buttonX = 30 + (buttonW+space)*i;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:buttonImages[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = TAG_FOR_BUTTON + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:button];
        
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom+10, 60, 12)];
        titleLabel.centerX = button.centerX;
        titleLabel.textColor = [MY_Util setColorWithInt:0x666666];
        titleLabel.font = MY_Font(12);
        titleLabel.text = buttonTitles[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.buttonView addSubview:titleLabel];
    }
    self.height = self.buttonView.bottom;
}

- (void)buttonAction:(UIButton*)button {
    if (self.buttonBlock) {
        self.buttonBlock(button.tag-TAG_FOR_BUTTON+1);
    }
}

@end
