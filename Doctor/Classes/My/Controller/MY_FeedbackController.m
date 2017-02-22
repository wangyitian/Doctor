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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_NAVBAR_HEIGHT, 0, 0, 0);
    [self setTitle:@"意见反馈" isBackButton:YES rightBttonName:nil rightImageName:nil];
    [self setupUI];
}

- (void)setupUI {
    MY_FeedbackView *feedbackView = [[MY_FeedbackView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    [self.scrollView addSubview:feedbackView];
}
@end
