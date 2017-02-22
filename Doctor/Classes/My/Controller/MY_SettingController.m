//
//  MY_SettingController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_SettingController.h"
#import "MY_MyCell.h"
#import "MY_ChangePWDController.h"
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
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1) {
            MY_ChangePWDController *vc = [[MY_ChangePWDController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1) {
            
        }
    }
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_MyCell class];
}

@end
