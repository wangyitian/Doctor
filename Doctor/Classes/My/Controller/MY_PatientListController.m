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
@interface MY_PatientListController ()

@end

@implementation MY_PatientListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self falseData];
}

- (void)setupUI {
    [self setTitle:@"患者推荐" isBackButton:YES rightBttonName:nil rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    
}

- (void)falseData {
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 5; i++) {
        MY_RecommendModel *model = [[MY_RecommendModel alloc] init];
        if (i == 0) {
            model.isFirst = YES;
        }
        model.name = [NSString stringWithFormat:@"坑爹%d",i];
        [array addObject:model];
    }
    
    [self.dataSource addObject:array];
    [self.tableView reloadData];
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_RecommendCell class];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MY_RecommendModel *model = [[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row];
    
    MY_PatientScheduleController *vc = [[MY_PatientScheduleController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
