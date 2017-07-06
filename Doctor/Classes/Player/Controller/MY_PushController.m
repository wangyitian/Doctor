//
//  MY_PushController.m
//  Doctor
//
//  Created by 王翼天 on 2017/7/5.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PushController.h"
#import "TXRTMPSDK/TXLivePush.h"
@interface MY_PushController ()

@property (nonatomic, strong) TXLivePushConfig *pushConfig;
@property (nonatomic, strong) TXLivePush *push;

@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UIButton *startButton;

@end

@implementation MY_PushController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)startPush {
    [self startPushWithUrl:@"rtmp://pc7bd03eb.live.126.net/live/1c1c6329e9ab4ab6837348c23342e775?wsSecret=57815468b33f5347be64785f696534aa&wsTime=1499239594"];
}

- (void)closeButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupUI {
    [self.push startPreview:self.view];
    
    self.titleTextField = [[UITextField alloc] init];
    self.titleTextField.placeholder = @"给直播写个标题吧";
    self.titleTextField.textAlignment = NSTextAlignmentCenter;
    self.titleTextField.textColor = [UIColor whiteColor];
    [self.view addSubview:self.titleTextField];
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startButton setTitle:@"开始直播" forState:UIControlStateNormal];
    [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.startButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.startButton addTarget:self action:@selector(startPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 35));
        make.bottom.mas_equalTo(self.view).mas_offset(-100);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.top.mas_equalTo(self.view).mas_offset(50);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)startPushWithUrl:(NSString*)url {
    [self.push startPush:url];
    [self.titleTextField removeFromSuperview];
    [self.startButton removeFromSuperview];
}

- (TXLivePushConfig *)pushConfig {
    if (!_pushConfig) {
        _pushConfig = [[TXLivePushConfig alloc] init];
        _pushConfig.enableNearestIP = NO;
    }
    return _pushConfig;
}

- (TXLivePush *)push {
    if (!_push) {
        _push = [[TXLivePush alloc] initWithConfig:self.pushConfig];
        [_push setVideoQuality:VIDEO_QUALITY_HIGH_DEFINITION adjustBitrate:NO adjustResolution:NO];
    }
    return _push;
}

@end
