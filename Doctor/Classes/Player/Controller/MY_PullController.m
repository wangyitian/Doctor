//
//  MY_PullController.m
//  Doctor
//
//  Created by 王翼天 on 2017/7/6.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PullController.h"
#import "TXRTMPSDK/TXLivePlayer.h"
#import "TXRTMPSDK/TXLivePlayListener.h"
@interface MY_PullController () <TXLivePlayListener>
//@property (nonatomic, strong) UIView *playerView;
@property (nonatomic, strong) TXLivePlayer *player;


@end

@implementation MY_PullController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self startPlayWithUrl:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)setupUI {
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(MY_ScreenWidth-20-30, 50, 20, 20);
    [closeButton setImage:[UIImage imageNamed:@"live_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
}

- (void)stop {
    [self.player stopPlay];
    [self.player removeVideoWidget];
}

- (void)startPlayWithUrl:(NSString*)url {
    [self showLoading];
    TXLivePlayConfig*  _config = [[TXLivePlayConfig alloc] init];
    
    //自动模式
//    _config.bAutoAdjustCacheTime   = YES;
//    _config.minAutoAdjustCacheTime = 1;
//    _config.maxAutoAdjustCacheTime = 5;
    //极速模式
    _config.bAutoAdjustCacheTime   = YES;
    _config.minAutoAdjustCacheTime = 1;
    _config.maxAutoAdjustCacheTime = 1;
    
    _config.connectRetryCount = 1;
    _config.connectRetryInterval = 3;
    //流畅模式
//    _config.bAutoAdjustCacheTime   = NO;
//    _config.cacheTime              = 5;
    [self.player setConfig:_config];
    
    //用 setupVideoWidget 给播放器绑定决定渲染区域的view，其首个参数 frame 在 1.5.2 版本后已经废弃
    //使用 startPlay 即可开始播放，如果是直播的话我们推荐 FLV 协议
    if (self.isLive) {
        int result = [self.player startPlay:self.model.url type:PLAY_TYPE_LIVE_RTMP];
        NSLog(@"~~~~~~%d",result);
    } else {
        [self.player setRenderMode:RENDER_MODE_FILL_EDGE];
        int result = [self.player startPlay:self.model.url type:PLAY_TYPE_VOD_MP4];
        NSLog(@"______%d",result);
    }
}

- (void)onPlayEvent:(int)EvtID withParam:(NSDictionary *)param {
    if (EvtID == PLAY_EVT_PLAY_BEGIN) {
        [self hideLoading];
    }
    
    if (EvtID == PLAY_EVT_PLAY_END) {
        [self hideLoading];
        [self presentAlertWithMessage:@"该视频播放完毕" ConfirmAction:^(UIAlertAction * _Nullable action) {
            [self.navigationController popViewControllerAnimated:YES];
        } completion:nil];
    }
    
    if (EvtID == PLAY_WARNING_SHAKE_FAIL || EvtID == PLAY_WARNING_RECONNECT || EvtID == PLAY_ERR_NET_DISCONNECT || EvtID == PLAY_WARNING_SEVER_CONN_FAIL) {
        [self hideLoading];
        [self presentAlertWithMessage:@"该直播已经结束" ConfirmAction:^(UIAlertAction * _Nullable action) {
            [self.navigationController popViewControllerAnimated:YES];
        } completion:nil];
    }
}

- (void)onNetStatus:(NSDictionary *)param {
    
}

- (TXLivePlayer *)player {
    if (!_player) {
        _player = [[TXLivePlayer alloc] init];
        _player.delegate = self;
        [_player setupVideoWidget:[UIScreen mainScreen].bounds containView:self.view insertIndex:0];
    }
    return _player;
}

- (void)closeButtonAction {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.player stopPlay];
        [self.player removeVideoWidget];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];
}
@end
