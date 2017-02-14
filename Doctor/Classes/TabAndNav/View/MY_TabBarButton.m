//
//  MY_TabBarButton.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_TabBarButton.h"
#define Ratio  0.6
@implementation MY_TabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = MY_Font(11);
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        
        MY_BadgeButton *badgeButton = [[MY_BadgeButton alloc] init];
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * Ratio;
    return CGRectMake(0, 0, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleY = contentRect.size.height * Ratio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * (1-Ratio);
    return CGRectMake(0 , titleY, titleW, titleH);
}

- (void)setHighlighted:(BOOL)highlighted {}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    _tabBarItem = tabBarItem;
    
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"title" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"image" options:0 context:nil];
    [tabBarItem addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc {
    [self.tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
    [self.tabBarItem removeObserver:self forKeyPath:@"title"];
    [self.tabBarItem removeObserver:self forKeyPath:@"image"];
    [self.tabBarItem removeObserver:self forKeyPath:@"selectedImage"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    // 设置文字、图片
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.image forState:UIControlStateNormal];
    [self setImage:self.tabBarItem.selectedImage forState:UIControlStateSelected];
    
    // 设置提醒数字
    self.badgeButton.badgeValue = self.tabBarItem.badgeValue;
    
    // 设置提醒数字的位置
    CGFloat badgeY = 5;
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGRect badgeF = self.badgeButton.frame;
    badgeF.origin.x = badgeX;
    badgeF.origin.y = badgeY;
    self.badgeButton.frame = badgeF;
}

@end
