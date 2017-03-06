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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)setupUI {
    [self setTitle:@"服务进度" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 49, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 40)];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = tableHeaderView;
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.layer.borderColor = [MY_Util setColorWithInt:0xababab].CGColor;
    phoneButton.layer.borderWidth = 0.5;
    phoneButton.backgroundColor = [UIColor whiteColor];
    [phoneButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    phoneButton.titleLabel.font = MY_Font(17);
    [phoneButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    [phoneButton addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneButton];
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 49));
    }];
    
    
    
    [self falseData];
}

- (void)falseData {
    MY_ScheduleModel *model = [[MY_ScheduleModel alloc] init];
    model.name = @"发生的";
    model.status = @"1";
    model.detail = @"为飞机啊快点放假快速的减肥了看电视剧 ";
    model.time = @"20142222";
    NSArray *array = [NSArray arrayWithObjects:model,model,model,model,model, nil];
    [self.dataSource addObject:array];
    [self.tableView reloadData];
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_ScheduleCell class];
}

- (void)phoneButtonAction {
    
}

@end
