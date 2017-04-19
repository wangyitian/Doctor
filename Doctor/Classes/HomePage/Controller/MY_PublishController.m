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
//    self.publishView.projectLabel.text
//    self.publishView.contentTextView.text
//    model postDataWithURL:@"" paramter:<#(NSDictionary *)#> success:<#^(NSURLSessionDataTask *operation, NSDictionary *dic)success#>
}

@end
