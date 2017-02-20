//
//  MY_SettingController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_SettingController.h"

@interface MY_SettingController ()

@end

@implementation MY_SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"设置" isBackButton:YES rightBttonName:nil rightImageName:nil];
    [self initData];
}

- (void)initData {
    NSArray *section1 = [NSArray arrayWithObjects:@"清楚缓存", nil];
    NSArray *section2 = [NSArray arrayWithObjects:@"客服电话",@"修改密码", nil];
    NSArray *section3 = [NSArray arrayWithObjects:@"意见反馈",@"关于我们", nil];
    [self.dataSource addObject:section1];
    [self.dataSource addObject:section2];
    [self.dataSource addObject:section3];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (1) {
        
    }
}

@end
