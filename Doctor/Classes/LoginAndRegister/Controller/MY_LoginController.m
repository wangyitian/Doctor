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
                //保存账号和友盟统计
                MY_AccountModel *account = [[MY_AccountModel alloc] initWithDictionary:dic[@"data"]];
                [MY_Util saveAccount:account];
                [MobClick profileSignInWithPUID:account.phonen];
                
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
                //保存账号和友盟统计
                MY_AccountModel *model = [[MY_AccountModel alloc] initWithDictionary:dic[@"data"]];
                [MY_Util saveAccount:model];
                [MobClick profileSignInWithPUID:model.phonen provider:@"WeChatLogin"];
                
                MY_TabController *tabVC = [[MY_TabController alloc] init];
                [[UIApplication sharedApplication].delegate window].rootViewController = tabVC;
                CATransition *anim = [CATransition animation];
                anim.type = @"rippleEffect";
                anim.duration = 1;
                [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
                
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
