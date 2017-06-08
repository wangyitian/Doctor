//
//  MY_ChangePWDController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ChangePWDController.h"
#import "MY_ChangePWDView.h"
@interface MY_ChangePWDController ()

@end

@implementation MY_ChangePWDController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"修改密码" isBackButton:YES rightBttonName:nil rightImageName:nil];
    
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    MY_ChangePWDView *changePwdView = [[MY_ChangePWDView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    changePwdView.isRegister = NO;
    
    __weak typeof(changePwdView) weakRegisterView = changePwdView;
    changePwdView.validateBlock = ^(NSString *phone) {
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        model.delegate = self;
        NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
        [paramters setObject:phone forKey:@"phonen"];
        [model getDataWithURL:MY_API_GET_CODE paramter:paramters success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            [self.view makeToast:@"获取短信验证码成功" duration:2 position:CSToastPositionCenter];
            [weakRegisterView timerFire];
        }];
    };
    changePwdView.confirmBlock = ^(NSString *phone, NSString *validate, NSString  *pwd) {
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
        [paramter setObject:phone forKey:@"phonen"];
        [paramter setObject:pwd forKey:@"password"];
        [paramter setObject:validate forKey:@"code"];
        [model postDataWithURL:MY_API_FORGET_PWD paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            [self.view makeToast:@"修改密码成功" duration:2 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }];
    };
    [self.scrollView addSubview:changePwdView];
}

@end
