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
    self.imageView = [[UIImageView alloc] init];
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 140*MY_ScreenWidth/375));
    }];
    
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.textColor = [MY_Util setColorWithInt:0x999999];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    self.typeLabel.backgroundColor = [MY_Util setColorWithInt:0xffffff];
    self.typeLabel.alpha = 0.3;
    [self.imageView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.imageView);
        make.size.mas_equalTo(CGSizeMake(190, 50));
    }];
    
    self.buttonView = [[UIView alloc] init];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    self.buttonView.backgroundColor = MY_RandomColor;
    [self addSubview:self.buttonView];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self.imageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 44));
    }];
    NSArray *buttontitles = [NSArray arrayWithObjects:@"课程详情",@"课程安排",@"课程费用",@"联系方式", nil];
    for (int i = 0; i < buttontitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttontitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(16);
        button.tag = TAG_FOR_BUTTON + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.buttonView).with.offset(MY_ScreenWidth/buttontitles.count*i);
            make.top.mas_equalTo(self.buttonView);
            make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth/buttontitles.count, 42));
        }];
        if (i == 0) {
            [self buttonAction:button];
        }
    }
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [MY_Util setColorWithInt:0xdddddd];
    [self.buttonView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.buttonView);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 0.5));
        make.bottom.mas_equalTo(self.buttonView);
    }];
    self.selectedLineView = [[UIView alloc] init];
    self.selectedLineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.buttonView addSubview:self.selectedLineView];
    [self.selectedLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.buttonView);
        make.bottom.mas_equalTo(self.buttonView);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth/buttontitles.count, 2));
    }];
    
    UIView *space = [[UIView alloc] init];
    space.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:space];
    [space mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self.buttonView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 5));
    }];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.backgroundColor = MY_RandomColor;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(space.mas_bottom);
        make.width.mas_equalTo(MY_ScreenWidth);
        make.bottom.mas_equalTo(self);
    }];
    
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
