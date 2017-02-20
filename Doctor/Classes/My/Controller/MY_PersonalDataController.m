//
//  MY_PersonalDataController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PersonalDataController.h"
#import "MY_PersonalDataCell.h"
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

- (Class)cellClassForObject:(id)object {
    return [MY_PersonalDataCell class];
}

@end
