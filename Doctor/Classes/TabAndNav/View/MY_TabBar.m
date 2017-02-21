//
//  MY_TabBar.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_TabBar.h"
#import "MY_TabBarButton.h"
@interface MY_TabBar ()
@property (nonatomic, strong) NSMutableArray *tabBarButtons;
@property (nonatomic, weak) MY_TabBarButton *selectedButton;

@end

@implementation MY_TabBar

- (NSMutableArray *)tabBarButtons {
    if (_tabBarButtons == nil) {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [MY_Util setColorWithInt:0xfcfcfc];
    }
    return self;
}

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem *)tabBarItem {
    MY_TabBarButton *button = [[MY_TabBarButton alloc] init];
    [self addSubview:button];
    
    [self.tabBarButtons addObject:button];
    
    button.tabBarItem = tabBarItem;
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.tabBarButtons.count == 1) {
        [self buttonClick:button];
    }
}

- (void)buttonClick:(MY_TabBarButton*)button {
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.tabBarButtons.count;
    CGFloat buttonY = 0;
    
    for (int i = 0; i < self.tabBarButtons.count; i++) {
        MY_TabBarButton *button = self.tabBarButtons[i];
        button.frame = CGRectMake(buttonW * i, buttonY, buttonW, buttonH);
        button.tag = i;
    }
    
}

@end
