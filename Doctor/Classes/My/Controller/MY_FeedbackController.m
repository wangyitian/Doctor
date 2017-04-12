//
//  MY_FeedbackController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_FeedbackController.h"
#import "MY_FeedbackView.h"
@interface MY_FeedbackController ()

@end

@implementation MY_FeedbackController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    [self setTitle:@"意见反馈" isBackButton:YES rightBttonName:nil rightImageName:nil];
    [self setupUI];
}

#pragma mark - UI
- (void)setupUI {
    MY_FeedbackView *feedbackView = [[MY_FeedbackView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    feedbackView.confirmBlock = ^(NSString *suggest, NSString*phone){
        MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
        NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
        [paramter setObject:suggest forKey:@"feedback"];
        [paramter setObject:phone forKey:@"contact"];
        [paramter setObject:[MY_Util getUid] forKey:@"uid"];
        [model postDataWithURL:MY_API_FEEDBACK paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:dic[@"message"] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    };
    [self.scrollView addSubview:feedbackView];
    self.scrollView.contentSize = feedbackView.frame.size;
}
@end
