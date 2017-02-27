//
//  MY_CollegeController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CollegeController.h"
#import "MY_CollegeHeaderView.h"
@interface MY_CollegeController ()

@end

@implementation MY_CollegeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UITableViewStyle)getTableViewStyle {
    return UITableViewStyleGrouped;
}

- (void)setupUI {
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_STATUS_HEIGHT)];
    statusView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.view addSubview:statusView];
    
    self.tableView.tableHeaderView = [[MY_CollegeHeaderView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 90)];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 10)];
    header.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    return header;
}

@end
