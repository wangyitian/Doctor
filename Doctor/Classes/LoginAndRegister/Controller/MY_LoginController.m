//
//  MY_LoginController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/16.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UMSocialCore/UMSocialCore.h>
#import "MY_LoginController.h"
#import "MY_RegisterController.h"
#import "MY_ForgetPWDController.h"
#import "MY_LoginView.h"
#import "MY_TabController.h"
@interface MY_LoginController ()
@property (nonatomic, assign) BOOL wechat;
@property (nonatomic, strong) UMSocialUserInfoResponse *resp;
@end

@implementation MY_LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)setupUI {
    MY_LoginView *loginView = [[MY_LoginView alloc] initWithFrame:self.view.bounds];
    loginView.forgetButtonClick = ^(){
        MY_ForgetPWDController *forgetVC = [[MY_ForgetPWDController alloc] init];
        [self.navigationController pushViewController:forgetVC animated:YES];
    };
    loginView.loginButtonBlock = ^(NSString*account, NSString*pwd){
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
        [paramter setObject:account forKey:@"phonen"];
        [paramter setObject:pwd forKey:@"password"];
        [model postDataWithURL:MY_API_LOGIN paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            [self.view makeToast:@"登录成功" duration:1 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                MY_AccountModel *account = [[MY_AccountModel alloc] initWithDictionary:dic[@"data"]];
                [MY_Util saveAccount:account];
//                MY_TabController *tabVC = [[MY_TabController alloc] init];
//                [UIView transitionFromView:self.view.window.rootViewController.view
//                                    toView:tabVC.view
//                                  duration:1.0
//                                   options:UIViewAnimationOptionTransitionCurlUp
//                                completion:^(BOOL finished)
//                 {
//                     [[UIApplication sharedApplication].delegate window].rootViewController = tabVC;
//                 }];
//                
                
                
                MY_TabController *tabVC = [[MY_TabController alloc] init];
                [[UIApplication sharedApplication].delegate window].rootViewController = tabVC;
                CATransition *anim = [CATransition animation];
                anim.type = @"rippleEffect";
                anim.duration = 1;
                [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
            }];
            
        }];
    };
    loginView.registerButtonClick = ^(){
        MY_RegisterController *registerVC = [[MY_RegisterController alloc] init];
        [self.navigationController pushViewController:registerVC animated:YES];
    };
    loginView.wechatButtonBlock = ^(){
        [self getAuthWithUserInfoFromWechat];
    };
    [self.scrollView addSubview:loginView];
    self.scrollView.contentSize = CGSizeMake(loginView.width, loginView.height);
}

- (void)getAuthWithUserInfoFromWechat {
    [self showLoading];
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            
            self.wechat = YES;
            self.resp = resp;
            MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
            NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
            [paramter setObject:resp.uid forKey:@"weixin_uid"];
            [model postDataWithURL:MY_API_LOGIN paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
                MY_AccountModel *model = [[MY_AccountModel alloc] initWithDictionary:dic[@"data"]];
                [MY_Util saveAccount:model];
                MY_TabController *tabVC = [[MY_TabController alloc] init];
                [[UIApplication sharedApplication].delegate window].rootViewController = tabVC;
            }];
        }
    }];
}

- (void)requestErrorWithModel:(MY_RequestModel *)requestModel responseDic:(NSDictionary *)responseDic {
    if ([requestModel.url isEqualToString:MY_API_LOGIN] && self.wechat) {
        [self hideLoading];
        MY_RegisterController *registerVC = [[MY_RegisterController alloc] init];
        registerVC.isWechat = YES;
        registerVC.wechatUid = self.resp.uid;
        registerVC.wechatOpenid = self.resp.openid;
        registerVC.wechatName = self.resp.name;
        registerVC.wechatIconUrl = self.resp.iconurl;
        [self.navigationController pushViewController:registerVC animated:YES];
    } else {
        [super requestErrorWithModel:requestModel responseDic:responseDic];
    }
}
@end
