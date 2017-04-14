//
//  MY_RecommendController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RecommendController.h"
#import "MY_RecommendView.h"
@interface MY_RecommendController ()

@end

@implementation MY_RecommendController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    [self setTitle:@"患者推荐" isBackButton:YES rightBttonName:nil rightImageName:nil];
    
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    MY_RecommendView *recommendView = [[MY_RecommendView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_ScreenHeight)];
    recommendView.recommendBlock = ^(NSDictionary *paramter) {
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        [model postDataWithURL:MY_API_PATIENT_RECOMMEND paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            [self presentAlertWithMessage:dic[@"message"] ConfirmAction:^(UIAlertAction *action) {
                [self.navigationController popViewControllerAnimated:YES];
            } completion:nil];
        }];
    };
    [self.scrollView addSubview:recommendView];
    self.scrollView.contentSize = CGSizeMake(MY_ScreenWidth, recommendView.height+30);
}
@end
