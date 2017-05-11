//
//  MY_PatientListController.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/13.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PatientListController.h"
#import "MY_RecommendCell.h"
#import "MY_RecommendModel.h"
#import "MY_PatientScheduleController.h"
#import "MY_RecommendController.h"
@interface MY_PatientListController ()

@end

@implementation MY_PatientListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self loadData];
}

- (void)setupUI {
    [self setTitle:@"患者推荐" isBackButton:YES rightBttonName:@"推荐患者" rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    [self addHeaderRefresh:YES footerRefresh:NO];
    
}

- (void)headerRereshing {
    [self loadData];
}

- (void)loadData {
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:[MY_Util getUid] forKey:@"uid"];
    [model getDataWithURL:MY_API_PATIENTLIST paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        NSMutableArray *patients = [NSMutableArray array];
        NSInteger index = 0;
        for (NSDictionary *patientDic in dic[@"patient"]) {
            MY_RecommendModel *model  = [[MY_RecommendModel alloc] initWithDictionary:patientDic];
            if (index == 0) {
                model.isFirst = YES;
            }
            [patients addObject:model];
            index++;
        }
        [self.dataSource removeAllObjects];
        [self.dataSource addObject:patients];
        [self.tableView reloadData];
    }];
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_RecommendCell class];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MY_RecommendModel *model = [[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row];
    
    MY_PatientScheduleController *vc = [[MY_PatientScheduleController alloc] init];
    vc.patientId = model.patientId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightButtonAction {
    MY_RecommendController *recommendVC = [[MY_RecommendController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}

@end
