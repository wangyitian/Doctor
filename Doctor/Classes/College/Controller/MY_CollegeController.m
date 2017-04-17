//
//  MY_CollegeController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CollegeController.h"
#import "MY_CollegeHeaderView.h"
#import "MY_CourseIntroCell.h"
#import "MY_EnrollController.h"
#import "MY_SegmentController.h"
#import "MY_CourseListController.h"
#import "MY_CourseSegmentController.h"
#import "MY_CourseCustomedController.h"
@interface MY_CollegeController ()

@end

@implementation MY_CollegeController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self falseData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 假数据
- (void)falseData {
    NSArray *array = [NSArray arrayWithObjects:@"", nil];
    for (int i = 0; i < 5; i++) {
        [self.dataSource addObject:array];
    }
    [self.tableView reloadData];
}

#pragma mark - tableview样式
- (UITableViewStyle)getTableViewStyle {
    return UITableViewStyleGrouped;
}

#pragma mark - UI
- (void)setupUI {
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_STATUS_HEIGHT)];
    statusView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.view addSubview:statusView];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_STATUS_HEIGHT, 0, 50, 0);
    
    MY_CollegeHeaderView *tableHeaderView = [[MY_CollegeHeaderView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 90)];
    tableHeaderView.headerButtonBlock = ^(NSInteger index) {
       NSMutableArray *vcArray = [NSMutableArray array];
        NSArray *types = nil;
        if (index == 1) {
            types = [NSArray arrayWithObjects:@"全部",@"美国",@"台湾",@"新加坡", nil];
        } else if (index == 2) {
            types = [NSArray arrayWithObjects:@"全部",@"美国",@"台湾", nil];
        } else if (index == 3) {
            types = [NSArray arrayWithObjects:@"美国", nil];
        } else if (index == 4) {
            types = [NSArray arrayWithObjects:@"美国", nil];
        }
        for (NSString *type in types) {
            MY_CourseListController *rdVC = [[MY_CourseListController alloc] init];
            rdVC.listType = type;
            [vcArray addObject:rdVC];
        }
        MY_CourseSegmentController *vc = [[MY_CourseSegmentController alloc] initWithViewControllers:vcArray segmentViewHeight:45 + MY_APP_STATUS_NAVBAR_HEIGHT];
        vc.typeIndex = index;
        vc.types = types;
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.height -= 50;
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.backgroundColor = [UIColor whiteColor];
    [phoneButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    [phoneButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    phoneButton.titleLabel.font = MY_Font(15);
    phoneButton.frame = CGRectMake(0, self.view.height-49-50, MY_ScreenWidth/2, 50);
    [phoneButton addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneButton];
    
    UIButton *enrollButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enrollButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [enrollButton setTitle:@"立即报名" forState:UIControlStateNormal];
    [enrollButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    enrollButton.titleLabel.font = MY_Font(15);
    enrollButton.frame = CGRectMake(MY_ScreenWidth/2, self.view.height-49-50, MY_ScreenWidth/2, 50);
    [enrollButton addTarget:self action:@selector(enrollButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enrollButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height-49-50, MY_ScreenWidth, 0.5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xdddddd];
    [self.view addSubview:line];
}

#pragma mark - tableview delegate
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 10)];
    header.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section { return 0.1; }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return 10; }

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_CourseIntroCell class];
}

#pragma mark - 电话按钮点击事件
- (void)phoneButtonAction {
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        // 根据获取的platformType确定所选平台进行下一步操作
//        [self shareWebPageToPlatformType:platformType];
//    }];
}

#pragma mark - 报名按钮点击事件
- (void)enrollButtonAction {
    MY_EnrollController *enrollVC = [[MY_EnrollController alloc] init];
    [self.navigationController pushViewController:enrollVC animated:YES];
}

@end
