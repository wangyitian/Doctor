//
//  MY_PushLiveController.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PushLiveController.h"
#import "MY_PushMiddleView.h"
#import "MY_PushStartLiveView.h"
#import "GPUImageGaussianBlurFilter.h"
@interface MY_PushLiveController ()
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UITextView *titleTextField;
@property (nonatomic, weak) MY_PushMiddleView *middleView;
//@property (nonatomic, strong)
@end

@implementation MY_PushLiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.backView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.backView];
    
    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = 2.0;
    UIImage * image = [UIImage imageNamed:@"bg_zbfx"];
    UIImage *blurredImage = [blurFilter imageByFilteringImage:image];
    self.backView.image = blurredImage;
    
    MY_PushMiddleView *middleView = [[MY_PushMiddleView alloc] init];
    middleView.liveButtonBlock = ^() {
        MY_PushStartLiveView *view = [[MY_PushStartLiveView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:view];
        [self.middleView.titleTextField resignFirstResponder];
        self.middleView.hidden = YES;
    };
    [self.view addSubview:middleView];
    self.middleView = middleView;
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(@60);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 200));
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.middleView.titleTextField resignFirstResponder];
}

@end
