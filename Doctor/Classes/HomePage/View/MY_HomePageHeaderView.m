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

@end
@implementation MY_HomePageHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

@end
