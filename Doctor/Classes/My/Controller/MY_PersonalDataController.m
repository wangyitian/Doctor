//
//  MY_PersonalDataController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PersonalDataController.h"
#import "MY_PersonalDataCell.h"
#import "MY_ChangeNameController.h"
#import "MY_PersonalAvatarCell.h"
@interface MY_PersonalDataController ()

@end

@implementation MY_PersonalDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"个人资料" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_NAVBAR_HEIGHT, 0, 0, 0);
    [self initData];
}

- (void)initData {
    NSArray *dataArray = [NSArray arrayWithObjects:@"头像",@"昵称",@"真实姓名",@"手机号码",@"科室",@"医院", nil];
    [self.dataSource addObject:dataArray];
    [self.tableView reloadData];
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [MY_PersonalAvatarCell class];
    }
    return [MY_PersonalDataCell class];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    } else {
        MY_PersonalDataCell *cell = [MY_PersonalDataCell cellWithTablebView:tableView index:indexPath];
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        //    [cell setModel:nil index:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        
    } else if (indexPath.row == 1) {
        MY_ChangeNameController *vc = [[MY_ChangeNameController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 2) {
        MY_ChangeNameController *vc = [[MY_ChangeNameController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        
    } else if (indexPath.row == 4) {
        
    } else if (indexPath.row == 5) {
        
    }
}

@end
