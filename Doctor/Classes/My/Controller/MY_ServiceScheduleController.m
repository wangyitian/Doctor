//
//  MY_ServiceScheduleController.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/1.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ServiceScheduleController.h"
#import "MY_ScheduleModel.h"
#import "MY_ScheduleCell.h"
@interface MY_ServiceScheduleController ()

@end

@implementation MY_ServiceScheduleController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UI
- (void)setupUI {
    [self setTitle:@"服务进度" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 49, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 40)];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = tableHeaderView;
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.frame = CGRectMake(0, 0, MY_ScreenWidth, 49);
    phoneButton.bottom = self.view.bottom;
    phoneButton.layer.borderColor = [MY_Util setColorWithInt:0xababab].CGColor;
    phoneButton.layer.borderWidth = 0.5;
    phoneButton.backgroundColor = [UIColor whiteColor];
    [phoneButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    phoneButton.titleLabel.font = MY_Font(17);
    [phoneButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneButton];
    
    
    
    [self falseData];
}

#pragma mark - 假数据
- (void)falseData {
    MY_ScheduleModel *model = [[MY_ScheduleModel alloc] init];
    model.name = @"发生的";
    model.status = @"1";
    model.detail = @"为飞机啊快点放假快速的减肥了看电视剧 ";
    model.time = @"20142222";
    model.isFirst = YES;
    
    MY_ScheduleModel *model1 = [[MY_ScheduleModel alloc] init];
    model1.name = @"发生的";
    model1.status = @"1";
    model1.detail = @"为飞机啊快点放假快速的减肥了看电视剧 ";
    model1.time = @"20142222";
    
    MY_ScheduleModel *model2 = [[MY_ScheduleModel alloc] init];
    model2.name = @"发生的";
    model2.status = @"1";
    model2.detail = @"为飞机啊快点放假快速的减肥了看电视剧 ";
    model2.time = @"20142222";
    
    MY_ScheduleModel *model3 = [[MY_ScheduleModel alloc] init];
    model3.name = @"发生的";
    model3.status = @"1";
    model3.detail = @"为飞机啊快点放假快速的减肥了看电视剧为飞机啊快点放假快速的减肥了看电视剧 ";
    model3.time = @"20142222";
    
    MY_ScheduleModel *model4 = [[MY_ScheduleModel alloc] init];
    model4.name = @"发生的";
    model4.status = @"1";
    model4.detail = @"为飞机啊快点放假快速的减肥了看电视剧 ";
    model4.time = @"20142222";
    model4.isLast = YES;
    NSArray *array = [NSArray arrayWithObjects:model,model1,model2,model3,model4, nil];
    [self.dataSource addObject:array];
    [self.tableView reloadData];
}

#pragma mark - tableview delegate
- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_ScheduleCell class];
}

#pragma mark - 电话按钮点击事件
- (void)phoneButtonAction {
    
}

@end
