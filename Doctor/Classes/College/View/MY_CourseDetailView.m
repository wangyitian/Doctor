//
//  MY_CourseDetailView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/24.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseDetailView.h"
@interface MY_CourseDetailView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end
@implementation MY_CourseDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

@end
