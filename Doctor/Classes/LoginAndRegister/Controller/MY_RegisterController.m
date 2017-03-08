//
//  MY_RegisterController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RegisterController.h"
#import "MY_ChangePWDView.h"
@interface MY_RegisterController ()

@end

@implementation MY_RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    [self setTitle:@"注册" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    MY_ChangePWDView *registerView = [[MY_ChangePWDView alloc] initWithFrame:self.view.bounds];
    
//    __block typeof(registerView) weakRegisterView = registerView;
    registerView.validateBlock = ^(NSString *account){
        MY_RequestModel *model = [[MY_RequestModel alloc] init];
        model.delegate = self;
        NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
        [paramters setObject:account forKey:@"phonen"];
        [model getDataWithURL:MY_API_GET_CODE paramter:paramters success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            [self.view makeToast:@"获取短信验证码成功" duration:2 position:CSToastPositionCenter];
        }];
    };
    registerView.confirmBlock = ^(NSString *account, NSString *pwd, NSString *validate){
        MY_RequestModel *model = [[MY_RequestModel alloc] init];
        model.delegate = self;
        NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
        [paramters setObject:account forKey:@"phonen"];
        [paramters setObject:pwd forKey:@"password"];
        [paramters setObject:validate forKey:@"code"];
        [model postDataWithURL:MY_API_REGISTER paramter:paramters success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            
        }];
    };
    [self.scrollView addSubview:registerView];
}

@end
