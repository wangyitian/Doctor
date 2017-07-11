//
//  MY_PushController.m
//  Doctor
//
//  Created by 王翼天 on 2017/7/5.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PushController.h"
#import "TXRTMPSDK/TXLivePush.h"
#import "TXRTMPSDK/TXLivePushListener.h"
#import "UIView+Toast.h"
@interface MY_PushController ()<TXLivePushListener>

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

-(void)viewDidAppear:(BOOL)animated{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)startPush {
    [self startPushWithUrl:@"rtmp://pc7bd03eb.live.126.net/live/1c1c6329e9ab4ab6837348c23342e775?wsSecret=57815468b33f5347be64785f696534aa&wsTime=1499239594"];
}

- (void)closeButtonAction {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.push stopPreview];
        [self.push stopPush];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)cameraButtonAction {
    [self.push switchCamera];
}

- (void)setupUI {
    [self.push startPreview:self.view];
    
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    self.titleTextField.center = self.view.center;
    self.titleTextField.placeholder = @"给直播写个标题吧";
    self.titleTextField.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    self.titleTextField.textAlignment = NSTextAlignmentCenter;
    self.titleTextField.textColor = [UIColor whiteColor];
    [self.view addSubview:self.titleTextField];
    
    self.startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startButton.frame = CGRectMake(0, self.view.height-100-35, 200, 35);
    self.startButton.centerX = self.view.centerX;
    [self.startButton setTitle:@"开始直播" forState:UIControlStateNormal];
    [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.startButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.startButton addTarget:self action:@selector(startPush) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(self.view.width-20-30, 50, 20, 20);
    [closeButton setImage:[UIImage imageNamed:@"live_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.frame = CGRectMake(30, 50, 20, 20);
    [cameraButton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(cameraButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)startPushWithUrl:(NSString*)url {
    [self.push startPush:url];
    [self.titleTextField removeFromSuperview];
    [self.startButton removeFromSuperview];
    [self showLoading];
}

- (void)onNetStatus:(NSDictionary *)param {
    
}

- (void)onPushEvent:(int)EvtID withParam:(NSDictionary *)param {
    if (EvtID == PUSH_EVT_PUSH_BEGIN) {
        [self.view makeToast:@"开始直播" duration:2 position:CSToastPositionCenter];
        [self hideLoading];
    }
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
        _push.delegate = self;
        [_push setVideoQuality:VIDEO_QUALITY_HIGH_DEFINITION adjustBitrate:NO adjustResolution:NO];
    }
    return _push;
}

@end
