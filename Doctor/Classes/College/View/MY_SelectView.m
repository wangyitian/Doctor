//
//  MY_SelectView.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_SelectView.h"
@interface MY_SelectView ()
@property (nonatomic, strong) UIView *mainView;
@end
@implementation MY_SelectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    self.mainView = [[UIView alloc] init];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.mainView.frame = CGRectMake(0, 0, MY_ScreenWidth, 0);
    [self addSubview:self.mainView];
}

- (void)setOptions:(NSArray *)options {
    _options = options;
    
    [self.mainView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat buttonX = 15;
    CGFloat buttonY = 10;
    CGFloat buttonH = 20;
    
    for (int i = 0; i < options.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:options[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(12);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 10;
        button.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
        button.layer.borderWidth = 1;
        button.tag = 2000 + i;
        CGFloat buttonW = [options[i] sizeWithAttributes:@{NSFontAttributeName:MY_Font(12)}].width + 16;
        
        if (buttonX+buttonW+15 > MY_ScreenWidth) {
            buttonX = 15;
            buttonY = buttonY + 20 + 10;
        }
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        buttonX = buttonX + 15 + buttonW;
        self.mainView.height = button.bottom + 10;
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:button];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (void)buttonAction:(UIButton*)button {
    if (self.selectedBlock) {
        self.selectedBlock(button.titleLabel.text);
    }
}

@end
