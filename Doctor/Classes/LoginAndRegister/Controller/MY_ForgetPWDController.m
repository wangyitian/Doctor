//
//  MY_ForgetPWDController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ForgetPWDController.h"
#import "MY_ChangePWDView.h"
@interface MY_ForgetPWDController ()

@end

@implementation MY_ForgetPWDController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    [self setTitle:@"忘记密码" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    MY_ChangePWDView *registerView = [[MY_ChangePWDView alloc] initWithFrame:self.view.bounds];
    registerView.isRegister = NO;
    
    
    __weak typeof(registerView) weakRegisterView = registerView;
    registerView.validateBlock = ^(NSString *account){
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        model.delegate = self;
        NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
        [paramters setObject:account forKey:@"phonen"];
        [model getDataWithURL:MY_API_GET_CODE paramter:paramters success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            [self.view makeToast:@"获取短信验证码成功" duration:2 position:CSToastPositionCenter];
            [weakRegisterView timerFire];
        }];
    };
    registerView.confirmBlock = ^(NSString *account, NSString *validate, NSString *pwd){
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
        [paramter setObject:account forKey:@"phonen"];
        [paramter setObject:pwd forKey:@"password"];
        [paramter setObject:validate forKey:@"code"];
        [model postDataWithURL:MY_API_FORGET_PWD paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            [self.view makeToast:@"修改密码成功" duration:2 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }];
    };
    [self.scrollView addSubview:registerView];
}

@end
