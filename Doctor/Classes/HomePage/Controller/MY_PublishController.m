//
//  MY_PublishController.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PublishController.h"
#import "MY_PublishView.h"
@interface MY_PublishController ()
@property (nonatomic, weak) MY_PublishView *publishView;
@end

@implementation MY_PublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
}

- (void)setupUI {
    [self setTitle:@"发布心得" isBackButton:YES rightBttonName:@"发布" rightImageName:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    
    MY_PublishView *publishView = [[MY_PublishView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_ScreenHeight)];
    [self.scrollView addSubview:publishView];
    self.publishView = publishView;
}

- (void)rightButtonAction {
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:[MY_Util getUid] forKey:@"uid"];
    [paramter setObject:self.publishView.contentTextView.text forKey:@"experience"];
    if (![self.publishView.projectLabel.text isEqualToString:@"---请选择---"]) {
        [paramter setObject:self.publishView.projectLabel.text forKey:@"project"];
    }
    [model postDataWithURL:MY_API_PUBLISH paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        [self presentAlertWithMessage:dic[@"message"] ConfirmAction:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        } completion:nil];
    }];
}

@end
