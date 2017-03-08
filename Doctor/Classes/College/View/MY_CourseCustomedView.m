//
//  MY_CourseCustomedView.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/8.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseCustomedView.h"

@interface MY_CourseCustomedView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MY_CourseCustomedView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

@end
