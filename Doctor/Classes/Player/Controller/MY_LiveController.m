//
//  MY_LiveController.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_LiveController.h"
#import "MY_PushLiveController.h"
#import "MY_PullLiveController.h"
@interface MY_LiveController ()

@end

@implementation MY_LiveController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushButton setTitle:@"推流" forState:UIControlStateNormal];
    [pushButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    pushButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    pushButton.layer.borderWidth = 1;
    [pushButton addTarget:self action:@selector(pushButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    [pushButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@100);
        make.left.mas_equalTo(@100);
        make.right.mas_equalTo(self.view).with.offset(-100);
        make.height.mas_equalTo(@40);
    }];
    
    UIButton *pullButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pullButton setTitle:@"拉流" forState:UIControlStateNormal];
    [pullButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    pullButton.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    pullButton.layer.borderWidth = 1;
    [pullButton addTarget:self action:@selector(pullButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pullButton];
    [pullButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@160);
        make.left.mas_equalTo(@100);
        make.right.mas_equalTo(self.view).with.offset(-100);
        make.height.mas_equalTo(@40);
    }];
    
}

- (void)pushButtonAction {
    MY_PushLiveController *pushVC = [[MY_PushLiveController alloc] init];
    [MY_Util pushAnimationFromVC:self toVC:pushVC];
}

- (void)pullButtonAction {
    MY_PullLiveController *pullVC = [[MY_PullLiveController alloc] init];
    pullVC.liveUrl = @"http://pull99.a8.com/live/1489388043041503.flv?ikHost=ws&ikOp=1&CodecInfo=8192";
    pullVC.imageUrl = @"http://img2.inke.cn/MTQ4ODkwMTMwMDkxNyMyMyNqcGc=.jpg";
    [MY_Util pushAnimationFromVC:self toVC:pullVC];
}

@end
