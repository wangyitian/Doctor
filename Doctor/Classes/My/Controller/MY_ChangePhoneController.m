//
//  MY_ChangePhoneController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ChangePhoneController.h"
#import "MY_ChangePhoneView.h"
@interface MY_ChangePhoneController ()

@end

@implementation MY_ChangePhoneController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    [self setTitle:@"修改手机号" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    
    MY_ChangePhoneView *changePhoneView = [[MY_ChangePhoneView alloc] initWithFrame:self.view.bounds];
    __block typeof(changePhoneView) weakPhoneView = changePhoneView;
    changePhoneView.validateBlcok = ^(NSString *phone) {
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        model.delegate = self;
        NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
        [paramters setObject:phone forKey:@"phonen"];
        [model getDataWithURL:MY_API_GET_CODE paramter:paramters success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            [self.view makeToast:@"获取短信验证码成功" duration:2 position:CSToastPositionCenter];
            [weakPhoneView timerFire];
        }];
    };
    changePhoneView.confirmBlock = ^(NSString *phone, NSString*validate) {
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
        [paramter setObject:phone forKey:@"phonen"];
        [paramter setObject:validate forKey:@"code"];
        [paramter setObject:[MY_Util getUid] forKey:@"uid"];
        [model postDataWithURL:MY_API_CHANGE_PHONE paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            
        }];
    };
    [self.scrollView addSubview:changePhoneView];
}

@end
