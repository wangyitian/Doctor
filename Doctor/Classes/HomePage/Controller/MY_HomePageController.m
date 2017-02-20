//
//  MY_HomePageController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_HomePageController.h"

@interface MY_HomePageController ()

@end

@implementation MY_HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"首页" isBackButton:YES rightBttonName:@"search" rightImageName:nil];
}

- (void)rightButtonAction {
    UISearchController *vc = [[UISearchController alloc] initWithSearchResultsController:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
