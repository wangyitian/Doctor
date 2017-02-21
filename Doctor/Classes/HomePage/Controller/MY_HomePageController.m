//
//  MY_HomePageController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_HomePageController.h"
#import <UShareUI/UShareUI.h>
@interface MY_HomePageController () <UISearchBarDelegate>

@end

@implementation MY_HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeInfoDark];
    bu.frame = CGRectMake(100, 100, 100, 100);
    [bu addTarget:self action:@selector(aa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bu];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}



- (void)aa {
    
}

- (void)initNavBar {
    self.navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_APP_STATUS_NAVBAR_HEIGHT)];
    self.navBar.backgroundColor = [UIColor purpleColor];
    self.navBar.userInteractionEnabled = YES;
    [self.view addSubview:self.navBar];
}

@end
