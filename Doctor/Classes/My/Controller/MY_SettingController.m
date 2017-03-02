//
//  MY_SettingController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_SettingController.h"
#import "MY_SettingCell.h"
#import "MY_ChangePWDController.h"
#import "MY_FeedbackController.h"
#import "MY_AboutUSController.h"
@interface MY_SettingController ()

@end

@implementation MY_SettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self initData];
}

- (void)setupUI {
    [self setTitle:@"设置" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    
    UIButton *logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutButton.backgroundColor = [UIColor whiteColor];
    [logoutButton setTitle:@"退出账号" forState:UIControlStateNormal];
    [logoutButton setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
    logoutButton.titleLabel.font = MY_Font(15);
    [logoutButton addTarget:self action:@selector(logoutButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:logoutButton];
    [logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@44);
        make.top.mas_equalTo(@(44*3+5+10+10));
    }];
}

- (UITableViewStyle)getTableViewStyle {
    return UITableViewStyleGrouped;
}

- (void)initData {
    NSArray *section1 = [NSArray arrayWithObjects:@"清除缓存", nil];
    NSArray *section2 = [NSArray arrayWithObjects:@"客服电话",@"修改密码", nil];
    [self.dataSource addObject:section1];
    [self.dataSource addObject:section2];
    [self.tableView reloadData];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 5)];
        view.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
        return view;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 10)];
        view.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    } else {
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section { return 0.1; }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1) {
            MY_ChangePWDController *vc = [[MY_ChangePWDController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_SettingCell class];
}

- (void)logoutButtonAction {
    
}

@end
