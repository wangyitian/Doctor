//
//  MY_HomePageHeaderView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/27.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_HomePageHeaderView.h"
#import "SDCycleScrollView.h"

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
    self.imageScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 200*MY_ScreenWidth/375)];
    self.imageScrollView.backgroundColor = [UIColor redColor];
    [self addSubview:self.imageScrollView];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageScrollView.bottom+10, MY_ScreenWidth, 200)];
    self.buttonView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.buttonView];
    
    self.height = self.buttonView.bottom;
}

@end
