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
@property (nonatomic, strong) UIImageView *navBar;
@property (nonatomic, strong) UILabel *navLabel;
@end

@implementation MY_BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)requestFailedWithModel:(MY_RequestModel *)requestModel responseDic:(NSDictionary *)responseDic {
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    MY_BaseController *a = [[MY_BaseController alloc] init];
//    [self.navigationController pushViewController:a animated:YES];
//}

- (void)requestFailedForSingleLoginWithPreVC:(UIViewController*)preVC {
    MY_LoginController *loginVC = [[MY_LoginController alloc] init];
    loginVC.enterType = MY_EnterLoginTypeSingleLoginOut;
    loginVC.loginSuccessedBlock = ^() {
        ((MY_BaseController*)preVC).loginSuccessedBlock();
    };
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)requestFailedForServerErrorWithModel:(MY_RequestModel *)requestModel responseDic:(NSDictionary *)responseDic {
    
}

- (void)setTitle:(NSString *)title isBackButton:(BOOL)isBackButton rightBttonName:(NSString *)rightBttonName rightImageName:(NSString *)rightImageName {
    self.navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_APP_STATUS_NAVBAR_HEIGHT)];
    self.navBar.backgroundColor = [UIColor redColor];
    self.navBar.userInteractionEnabled = YES;
    [self.view addSubview:self.navBar];
    
    self.navLabel = [[UILabel alloc] initWithFrame:CGRectMake((MY_ScreenWidth - 200)/2, MY_STATUS_HEIGHT, 200, MY_NAVBAR_HEIGHT)];
    self.navLabel.font = [UIFont boldSystemFontOfSize:17];
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    self.navLabel.textColor = MY_Color(70, 71, 75);
    self.navLabel.text = title;
    [self.navBar addSubview:self.navLabel];
    
    if (isBackButton) {
        UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [backButton setFrame:CGRectMake(0, MY_STATUS_HEIGHT, 50, MY_NAVBAR_HEIGHT)];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(7, 10, 7, 10);
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.navBar addSubview:backButton];
    }
    if (rightBttonName) {
        
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
