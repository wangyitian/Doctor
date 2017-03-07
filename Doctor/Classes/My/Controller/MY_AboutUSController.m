//
//  MY_AboutUSController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_AboutUSController.h"
#import "MY_AboutUSView.h"
@interface MY_AboutUSController ()

@end

@implementation MY_AboutUSController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"关于我们" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.scrollView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    [self setupUI];
}

- (void)setupUI {
    MY_AboutUSView *aboutView = [[MY_AboutUSView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    [self.scrollView addSubview:aboutView];
    
}
@end
