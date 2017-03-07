//
//  MY_CourseListController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseListController.h"

@interface MY_CourseListController ()

@end

@implementation MY_CourseListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [self addHeaderRefresh:YES footerRefresh:YES];
    [self setupUI];
    [self loadMore:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadMore:(BOOL)loadMore {
    
}

- (void)headerRereshing {
    [self loadMore:NO];
}

- (void)footerRereshing {
    [self loadMore:YES];
}

- (void)setupUI {
}
@end
