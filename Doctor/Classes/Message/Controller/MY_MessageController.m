//
//  MY_MessageController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MessageController.h"
#import "MY_LoginController.h"
@interface MY_MessageController ()

@end

@implementation MY_MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeaderRefresh:YES footerRefresh:YES];
    [self loadMore:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadMore:(BOOL)loadMore {
    MY_LoginController *loginVC = [[MY_LoginController alloc] init];
    [MY_Util pushAnimationFromVC:self toVC:loginVC];
}

- (void)headerRereshing {
    [self loadMore:NO];
}

- (void)footerRereshing {
    [self loadMore:YES];
}

@end
