//
//  MY_PatientScheduleController.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/19.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PatientScheduleController.h"
#import "MY_PatientScheduleCell.h"
#import "MY_PatientScheduleModel.h"
@interface MY_PatientScheduleController ()

@end

@implementation MY_PatientScheduleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

- (void)setupUI {
    [self setTitle:@"患者推荐进度" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
}

- (void)loadData {
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:self.patientId forKey:@"id"];
    [paramter setObject:[MY_Util getUid] forKey:@"uid"];
    [model getDataWithURL:MY_API_PATIENTPROGRESS paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        NSMutableArray *progresses = [NSMutableArray array];
        for (int i=0; i<[dic[@"progress"] count]; i++) {
            MY_PatientScheduleModel *model = [[MY_PatientScheduleModel alloc] initWithDictionary:dic[@"progress"][i]];
            
            if (i == 0) {
                model.isFirst = YES;
            }
            if (i == [dic[@"progress"] count]-1) {
                model.isLast = YES;
            }
            
            [progresses addObject:model];
        }
        [self.dataSource removeAllObjects];
        [self.dataSource addObject:progresses];
        [self.tableView reloadData];
    }];
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_PatientScheduleCell class];
}


@end
