//
//  MY_MyController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MyController.h"
#import "MY_MyHeaderView.h"
#import "MY_MyCell.h"
#import "MY_PersonalDataController.h"
#import "MY_SettingController.h"
@interface MY_MyController ()

@end

@implementation MY_MyController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UITableViewStyle)getTableViewStyle {
    return UITableViewStyleGrouped;
}

- (void)setupUI {
    MY_MyHeaderView *tableHeaderView = [[MY_MyHeaderView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    tableHeaderView.personalDataBlock = ^(){
        MY_PersonalDataController *personalVC = [[MY_PersonalDataController alloc] init];
        [self.navigationController pushViewController:personalVC animated:YES];
    };
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
}

- (void)initData {
    NSArray *dataArray = [NSArray arrayWithObjects:@"我的学分",@"设置", nil];
    [self.dataSource addObject:dataArray];
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 10)];
    header.backgroundColor = [UIColor blueColor];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        MY_SettingController *settingVC = [[MY_SettingController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

- (Class)cellClassForObject:(id)object {
    return [MY_MyCell class];
}

@end
