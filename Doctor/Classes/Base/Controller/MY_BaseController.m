//
//  MY_BaseController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseController.h"
#import "MY_RequestModel.h"
#import "MY_LoginController.h"
@interface MY_BaseController ()

@end

@implementation MY_BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)requestFailedWithModel:(MY_RequestModel *)requestModel task:(NSURLSessionDataTask *)task error:(NSError *)error {
    
}

- (void)requestFailedForSingleLoginWithPreVC:(UIViewController*)preVC {
    MY_LoginController *loginVC = [[MY_LoginController alloc] init];
    loginVC.enterType = MY_EnterLoginTypeSingleLoginOut;
    loginVC.loginSuccessedBlock = ^() {
        ((MY_BaseController*)preVC).loginSuccessedBlock();
    };
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)requestErrorWithModel:(MY_RequestModel *)requestModel responseDic:(NSDictionary *)responseDic {
    
}

- (void)setTitle:(NSString *)title isBackButton:(BOOL)isBackButton rightBttonName:(NSString *)rightBttonName rightImageName:(NSString *)rightImageName {
    self.navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_APP_STATUS_NAVBAR_HEIGHT)];
    self.navBar.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    self.navBar.userInteractionEnabled = YES;
    [self.view addSubview:self.navBar];
    
    if (title.length) {
        self.navLabel = [[UILabel alloc] initWithFrame:CGRectMake((MY_ScreenWidth - 200)/2, MY_STATUS_HEIGHT, 200, MY_NAVBAR_HEIGHT)];
        self.navLabel.font = [UIFont boldSystemFontOfSize:17];
        self.navLabel.textAlignment = NSTextAlignmentCenter;
        self.navLabel.textColor = [UIColor whiteColor];
        self.navLabel.text = title;
        [self.navBar addSubview:self.navLabel];
    }
    
    if (isBackButton) {
        UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.titleLabel.font = MY_Font(13);
        [backButton setFrame:CGRectMake(0, MY_STATUS_HEIGHT, 70, MY_NAVBAR_HEIGHT)];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(18, 20, 19, 43);
        backButton.titleEdgeInsets = UIEdgeInsetsMake(15, 35, 15, 1);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:backButton];
    }
    if (rightBttonName) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setTitle:rightBttonName forState:UIControlStateNormal];
        [rightButton setTitleColor:[MY_Color(255, 255, 255) colorWithAlphaComponent:1] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [rightButton setFrame:CGRectMake(MY_ScreenWidth - 10 - 60, MY_STATUS_HEIGHT + (44 - 30)/2, 60, 30)];
        rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:rightButton];
    } else if (rightImageName) {
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:[UIImage imageNamed:rightImageName] forState:UIControlStateNormal];
        [rightButton setFrame:CGRectMake(MY_ScreenWidth - 10 - 80, MY_STATUS_HEIGHT + (44 - 30)/2, 80, 30)];
        rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:rightButton];
    }
}

- (void)rightButtonAction {
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
