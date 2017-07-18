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

#import "EaseChatView.h"
#import "AppDelegate.h"
#import "EaseHeartFlyView.h"
#import "EaseLiveHeaderListView.h"
#import "UIImage+Color.h"
#import "EaseProfileLiveView.h"
#import "EaseLiveRoom.h"
#import "EaseAdminView.h"

#define kDefaultTop 30.f
#define kDefaultLeft 10.f

@interface MY_PullController () <TXLivePlayListener,EaseChatViewDelegate,EaseLiveHeaderListViewDelegate,TapBackgroundViewDelegate,EMChatroomManagerDelegate,EaseProfileLiveViewDelegate,EMClientDelegate> {
    NSTimer *_burstTimer;
    EMChatroom *_chatroom;
    BOOL _enableAdmin;
}
@property (nonatomic, strong) TXLivePlayer *player;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *sendButton;
@property (nonatomic, strong) EaseChatView *chatview;
@property (nonatomic, strong) EaseLiveHeaderListView *headerListView;

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) UIView *liveView;
@property (nonatomic, strong) UILabel *roomNameLabel;

@property (nonatomic, strong) UITapGestureRecognizer *singleTapGR;

@end

@implementation MY_PullController

#pragma mark
#pragma mark - controller生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [self joinChatroom];
}

-(void)viewDidAppear:(BOOL)animated{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
    [[EMClient sharedClient] removeDelegate:self];
    _chatview.delegate = nil;
    _chatview = nil;
}

#pragma mark
#pragma mark - joinChatroom
- (void)joinChatroom {
    __weak MY_PullController *weakSelf = self;
    [self.chatview joinChatroomWithIsCount:YES
                                completion:^(BOOL success) {
                                    if (success) {
                                        [weakSelf.headerListView loadHeaderListWithChatroomId:[_room.chatroomId copy]];
                                        _chatroom = [[EMClient sharedClient].roomManager getChatroomSpecificationFromServerWithId:_room.chatroomId error:nil];
                                        [[EaseHttpManager sharedInstance] getLiveRoomWithRoomId:_room.roomId
                                                                                     completion:^(EaseLiveRoom *room, BOOL success) {
                                                                                         if (success) {
                                                                                             weakSelf.room = room;
                                                                                             [self startPlay];
                                                                                         } else {
                                                                                             [self startPlay];
                                                                                         }
                                                                                         [weakSelf.view bringSubviewToFront:weakSelf.liveView];
                                                                                         [weakSelf.view layoutSubviews];
                                                                                     }];
                                    } else {
                                        [self startPlay];
                                        [weakSelf showHint:@"加入聊天室失败"];
                                        [weakSelf.view bringSubviewToFront:weakSelf.liveView];
                                        [weakSelf.view layoutSubviews];
                                    }
                                }];
    [[EMClient sharedClient].roomManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    [self setupForDismissKeyboard];
}

#pragma mark
#pragma mark - EMChatroomManagerDelegate
- (void)userDidJoinChatroom:(EMChatroom *)aChatroom
                       user:(NSString *)aUsername {
    if ([aChatroom.chatroomId isEqualToString:_room.chatroomId]) {
        if (![aChatroom.owner isEqualToString:aUsername]) {
            [_headerListView joinChatroomWithUsername:aUsername];
        }
    }
}

- (void)userDidLeaveChatroom:(EMChatroom *)aChatroom
                        user:(NSString *)aUsername {
    if ([aChatroom.chatroomId isEqualToString:_room.chatroomId]) {
        if (![aChatroom.owner isEqualToString:aUsername]) {
            [_headerListView leaveChatroomWithUsername:aUsername];
        }
    }
}

- (void)didDismissFromChatroom:(EMChatroom *)aChatroom
                        reason:(EMChatroomBeKickedReason)aReason {
    [self presentAlertWithMessage:@"被踢出直播聊天室" ConfirmAction:nil completion:nil];
    [self closeButtonAction];
}

- (void)chatroomAdminListDidUpdate:(EMChatroom *)aChatroom
                        addedAdmin:(NSString *)aAdmin {
    if ([aChatroom.chatroomId isEqualToString:_room.chatroomId]) {
        if ([aAdmin isEqualToString:[EMClient sharedClient].currentUsername]) {
            _enableAdmin = YES;
            [self.view layoutSubviews];
        }
    }
}

- (void)chatroomAdminListDidUpdate:(EMChatroom *)aChatroom
                      removedAdmin:(NSString *)aAdmin {
    if ([aChatroom.chatroomId isEqualToString:_room.chatroomId]) {
        if ([aAdmin isEqualToString:[EMClient sharedClient].currentUsername]) {
            _enableAdmin = NO;
            [self.view layoutSubviews];
        }
    }
}

- (void)chatroomMuteListDidUpdate:(EMChatroom *)aChatroom
                addedMutedMembers:(NSArray *)aMutes
                       muteExpire:(NSInteger)aMuteExpire {
    if ([aChatroom.chatroomId isEqualToString:_room.chatroomId]) {
        NSMutableString *text = [NSMutableString string];
        for (NSString *name in aMutes) {
            [text appendString:name];
        }
        [self showHint:[NSString stringWithFormat:@"禁言成员:%@",text]];
    }
}

- (void)chatroomMuteListDidUpdate:(EMChatroom *)aChatroom
              removedMutedMembers:(NSArray *)aMutes {
    if ([aChatroom.chatroomId isEqualToString:_room.chatroomId]) {
        NSMutableString *text = [NSMutableString string];
        for (NSString *name in aMutes) {
            [text appendString:name];
        }
        [self showHint:[NSString stringWithFormat:@"解除禁言:%@",text]];
    }
}

- (void)chatroomOwnerDidUpdate:(EMChatroom *)aChatroom
                      newOwner:(NSString *)aNewOwner
                      oldOwner:(NSString *)aOldOwner {
    if ([aChatroom.chatroomId isEqualToString:_room.chatroomId]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"聊天室创建者有更新:%@",aChatroom.chatroomId] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"publish.ok", @"Ok") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self closeButtonAction];
        }];
        
        [alert addAction:ok];
    }
}

#pragma mark
#pragma mark - EaseChatViewDelegate
- (void)easeChatViewDidChangeFrameToHeight:(CGFloat)toHeight {
    if ([self.window isKeyWindow]) {
        return;
    }
    
    if (toHeight == 200) {
        [self.view removeGestureRecognizer:self.singleTapGR];
    } else {
        [self.view addGestureRecognizer:self.singleTapGR];
    }
    
    if (!self.chatview.hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.chatview.frame;
            rect.origin.y = self.view.frame.size.height - toHeight;
            self.chatview.frame = rect;
        }];
    }
}

- (void)didReceivePraiseWithCMDMessage:(EMMessage *)message {
    [self showTheLoveAction];
}

- (void)didSelectUserWithMessage:(EMMessage *)message {
    [self.view endEditing:YES];
    BOOL isOwner = _chatroom.permissionType == EMChatroomPermissionTypeOwner;
    BOOL ret = _chatroom.permissionType == EMChatroomPermissionTypeAdmin || isOwner;
    if (ret || _enableAdmin) {
        EaseProfileLiveView *profileLiveView = [[EaseProfileLiveView alloc] initWithUsername:message.from
                                                                                  chatroomId:_room.chatroomId
                                                                                     isOwner:isOwner];
        profileLiveView.delegate = self;
        [profileLiveView showFromParentView:self.view];
    }
}

- (void)didSelectAdminButton:(BOOL)isOwner {
    EaseAdminView *adminView = [[EaseAdminView alloc] initWithChatroomId:_room.chatroomId
                                                                 isOwner:isOwner];
    adminView.delegate = self;
    [adminView showFromParentView:self.view];
}
#pragma  mark
#pragma  mark - TapBackgroundViewDelegate
- (void)didTapBackgroundView:(EaseBaseSubView *)profileView {
    [profileView removeFromParentView];
}

#pragma mark
#pragma mark - EaseLiveHeaderListViewDelegate
- (void)didSelectHeaderWithUsername:(NSString *)username
{
    if ([self.window isKeyWindow]) {
        [self closeAction];
        return;
    }
    BOOL isOwner = _chatroom.permissionType == EMChatroomPermissionTypeOwner;
    BOOL ret = _chatroom.permissionType == EMChatroomPermissionTypeAdmin || isOwner;
    if (ret || _enableAdmin) {
        EaseProfileLiveView *profileLiveView = [[EaseProfileLiveView alloc] initWithUsername:username
                                                                                  chatroomId:_room.chatroomId
                                                                                     isOwner:isOwner];
        profileLiveView.delegate = self;
        [profileLiveView showFromParentView:self.view];
    } else {
        EaseProfileLiveView *profileLiveView = [[EaseProfileLiveView alloc] initWithUsername:username
                                                                                  chatroomId:_room.chatroomId];
        profileLiveView.delegate = self;
        [profileLiveView showFromParentView:self.view];
    }
}

#pragma mark
#pragma mark - 直播开始与结束
- (void)startPlay {
    [self showLoading];
    TXLivePlayConfig*  _config = [[TXLivePlayConfig alloc] init];
    //极速模式
    _config.bAutoAdjustCacheTime   = YES;
    _config.minAutoAdjustCacheTime = 1;
    _config.maxAutoAdjustCacheTime = 1;
    _config.connectRetryCount = 1;
    _config.connectRetryInterval = 3;
    [self.player setConfig:_config];
    //用 setupVideoWidget 给播放器绑定决定渲染区域的view，其首个参数 frame 在 1.5.2 版本后已经废弃
    //使用 startPlay 即可开始播放，如果是直播的话我们推荐 FLV 协议
    if (self.isLive) {
//        [self.player startPlay:self.room.session.mobilepullstream type:PLAY_TYPE_LIVE_RTMP];
        [self.player startPlay:self.model.url type:PLAY_TYPE_LIVE_RTMP];
    } else {
        [self.player setRenderMode:RENDER_MODE_FILL_EDGE];
        [self.player startPlay:self.model.url type:PLAY_TYPE_VOD_MP4];
    }
}

- (void)stop {
    [self.player stopPlay];
    [self.player removeVideoWidget];
}

#pragma mark
#pragma mark - 直播监控
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

#pragma mark
#pragma mark - notification
- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat y = endFrame.origin.y;
    
    if ([self.window isKeyWindow]) {
        if (y == KScreenHeight) {
            [UIView animateWithDuration:0.3 animations:^{
                self.window.top = KScreenHeight - 290.f;
                self.window.height = 290.f;
            }];
        } else  {
            [UIView animateWithDuration:0.3 animations:^{
                self.window.top = 0;
                self.window.height = KScreenHeight;
            }];
        }
    }
}

#pragma mark
#pragma mark - action
- (void)closeButtonAction {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.player stopPlay];
        [self.player removeVideoWidget];
        __weak typeof(self) weakSelf =  self;
        NSString *chatroomId = [_room.chatroomId copy];
        [weakSelf.chatview leaveChatroomWithIsCount:YES
                                         completion:^(BOOL success) {
                                             if (success) {
                                                 [[EMClient sharedClient].chatManager deleteConversation:chatroomId isDeleteMessages:YES completion:NULL];
                                             }
                                             [weakSelf dismissViewControllerAnimated:YES completion:NULL];
                                         }];
        [_burstTimer invalidate];
        _burstTimer = nil;
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)closeAction {
    [self.window resignKeyWindow];
    [UIView animateWithDuration:0.3 animations:^{
        self.window.top = KScreenHeight;
    } completion:^(BOOL finished) {
        self.window.hidden = YES;
        [self.view.window makeKeyAndVisible];
    }];
}

-(void)showTheLoveAction {
    EaseHeartFlyView* heart = [[EaseHeartFlyView alloc]initWithFrame:CGRectMake(0, 0, 55, 50)];
    [_chatview addSubview:heart];
    CGPoint fountainSource = CGPointMake(KScreenWidth - (20 + 50/2.0), _chatview.height);
    heart.center = fountainSource;
    [heart animateInView:_chatview];
}

#pragma mark
#pragma mark - ui
- (void)setupUI {
    [self.view addSubview:self.liveView];
    [self.liveView addSubview:self.closeButton];
    [self.liveView addSubview:self.chatview];
    [self.liveView addSubview:self.headerListView];
    [self.liveView addSubview:self.roomNameLabel];
}

#pragma mark
#pragma mark - getter
- (UIWindow*)window {
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:CGRectMake(0, KScreenHeight, KScreenWidth, 290.f)];
    }
    return _window;
}

- (EaseLiveHeaderListView*)headerListView {
    if (_headerListView == nil) {
        _headerListView = [[EaseLiveHeaderListView alloc] initWithFrame:CGRectMake(0, kDefaultTop, CGRectGetMinX(self.closeButton.frame), 30.f) room:_room];
        _headerListView.delegate = self;
        _headerListView.backgroundColor = [UIColor redColor];
    }
    return _headerListView;
}

- (UILabel*)roomNameLabel {
    if (_roomNameLabel == nil) {
        _roomNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 69.f, KScreenWidth - 20.f, 15)];
        _roomNameLabel.text = [NSString stringWithFormat:@"%@: %@" ,NSLocalizedString(@"live.room.name", @"Room ID") ,_room.roomId];
        _roomNameLabel.font = [UIFont systemFontOfSize:12.f];
        _roomNameLabel.textAlignment = NSTextAlignmentRight;
        _roomNameLabel.backgroundColor = [UIColor yellowColor];
        _roomNameLabel.textColor = [UIColor whiteColor];
    }
    return _roomNameLabel;
}

- (EaseChatView*)chatview {
    if (_chatview == nil) {
        _chatview = [[EaseChatView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 200, CGRectGetWidth(self.view.frame), 200) room:_room isPublish:NO];
        _chatview.backgroundColor = [UIColor purpleColor];
        _chatview.delegate = self;
    }
    return _chatview;
}

- (UIButton *)closeButton {
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.frame = CGRectMake(KScreenWidth - 40.f, kDefaultTop, 30.f, 30.f);
        [_closeButton setImage:[UIImage imageNamed:@"live_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.backgroundColor = [UIColor blueColor];
    }
    return _closeButton;
}

- (UIView *)liveView {
    if (!_liveView) {
        _liveView = [[UIView alloc] initWithFrame:self.view.bounds];
        _liveView.backgroundColor = [UIColor clearColor];
    }
    return _liveView;
}

- (TXLivePlayer *)player {
    if (!_player) {
        _player = [[TXLivePlayer alloc] init];
        _player.delegate = self;
        [_player setupVideoWidget:[UIScreen mainScreen].bounds containView:self.view insertIndex:0];
    }
    return _player;
}

#pragma mark
#pragma mark - Gesture
- (void)setupForDismissKeyboard {
    _singleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                           action:@selector(tapAnywhereToDismissKeyboard:)];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
    [self.chatview endEditing:YES];
}
@end
