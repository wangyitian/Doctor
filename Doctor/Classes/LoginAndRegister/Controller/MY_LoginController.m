//
//  MY_LoginController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/16.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_LoginController.h"
#import "MY_RegisterController.h"
#import "MY_ForgetPWDController.h"
#import "MY_LoginView.h"
#import "MY_TabController.h"
@interface MY_LoginController ()

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
                MY_TabController *tabVC = [[MY_TabController alloc] init];
                [[UIApplication sharedApplication].delegate window].rootViewController = tabVC;
            }];
        }];
    };
    loginView.registerButtonClick = ^(){
        MY_RegisterController *registerVC = [[MY_RegisterController alloc] init];
        [self.navigationController pushViewController:registerVC animated:YES];
    };
    loginView.tiyanButtonBlock = ^(){
        MY_TabController *tabVC = [[MY_TabController alloc] init];
        [[UIApplication sharedApplication].delegate window].rootViewController = tabVC;
    };
    
    [self.scrollView addSubview:loginView];
    self.scrollView.contentSize = CGSizeMake(loginView.width, loginView.height);
}

@end
