//
//  MY_CourseDetailView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/24.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseDetailView.h"
#define TAG_FOR_BUTTON  2000
@interface MY_CourseDetailView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIView *selectedLineView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *courseIntroView;
@property (nonatomic, strong) UIView *courseArrangeView;
@property (nonatomic, strong) UIView *courseCostView;
@property (nonatomic, strong) UIView *courseContactView;
@end
@implementation MY_CourseDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 140*MY_ScreenWidth/375)];
    [self addSubview:self.imageView];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 190, 50)];
    self.typeLabel.center = self.imageView.center;
    self.typeLabel.textColor = [MY_Util setColorWithInt:0x999999];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.backgroundColor = [MY_Util setColorWithInt:0xffffff];
    self.typeLabel.alpha = 0.3;
    [self.imageView addSubview:self.typeLabel];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageView.bottom, MY_ScreenWidth, 44)];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    self.buttonView.backgroundColor = MY_RandomColor;
    [self addSubview:self.buttonView];

    NSArray *buttontitles = [NSArray arrayWithObjects:@"课程详情",@"课程安排",@"课程费用",@"联系方式", nil];
    for (int i = 0; i < buttontitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(MY_ScreenWidth/buttontitles.count*i, 0, MY_ScreenWidth/buttontitles.count, 42);
        [button setTitle:buttontitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(16);
        button.tag = TAG_FOR_BUTTON + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:button];
        if (i == 0) {
            [self buttonAction:button];
        }
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonView.bottom-0.5, MY_ScreenWidth, 0.5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xdddddd];
    [self.buttonView addSubview:line];

    self.selectedLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonView.bottom-2, MY_ScreenWidth/buttontitles.count, 2)];
    self.selectedLineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.buttonView addSubview:self.selectedLineView];
    
    UIView *space = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonView.bottom, MY_ScreenWidth, 5)];
    space.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:space];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, space.bottom, MY_ScreenWidth, self.bottom-space.bottom)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.backgroundColor = MY_RandomColor;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.courseIntroView = [[UIView alloc] init];
    [self.scrollView addSubview:self.courseIntroView];
    
    self.courseArrangeView = [[UIView alloc] init];
    [self.scrollView addSubview:self.courseArrangeView];
    
    self.courseCostView = [[UIView alloc] init];
    [self.scrollView addSubview:self.courseCostView];
    
    self.courseContactView = [[UIView alloc] init];
    [self.scrollView addSubview:self.courseContactView];
}

- (void)buttonAction:(UIButton*)button {
    [UIView animateWithDuration:0.25 animations:^{
        self.selectedLineView.left = button.left;
    }];
}

@end
