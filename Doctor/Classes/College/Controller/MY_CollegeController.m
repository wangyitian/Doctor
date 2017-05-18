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
#import "MY_CourseIntroModel.h"
#import "MY_BaseWebController.h"
@interface MY_CollegeController ()

@end

@implementation MY_CollegeController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    [self loadData];
    
    [self addHeaderRefresh:YES footerRefresh:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}

- (void)headerRereshing {
    [self loadData];
}

#pragma mark - 假数据
- (void)loadData {
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    [model getDataWithURL:MY_API_COURSEINTRO paramter:nil success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *imageDic in dic[@"college"]) {
            MY_CourseIntroModel *model = [[MY_CourseIntroModel alloc] initWithDictionary:imageDic];
            [array addObject:model];
        }
        [self.dataSource removeAllObjects];
        [self.dataSource addObject:array];
        [self.tableView reloadData];
    }];
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
            rdVC.index = index;
            rdVC.listType = type;
            [vcArray addObject:rdVC];
        }
        MY_CourseSegmentController *vc = [[MY_CourseSegmentController alloc] initWithViewControllers:vcArray segmentViewHeight:45 + MY_APP_STATUS_NAVBAR_HEIGHT];
        vc.typeIndex = index;
        vc.types = types;
        for (MY_CourseListController *rdVC in vcArray) {
            rdVC.superVC = vc;
        }
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

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_CourseIntroCell class];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MY_CourseIntroModel *model = [[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row];
    
    if (model.url.length) {
        MY_BaseWebController *webVC = [[MY_BaseWebController alloc] init];
        webVC.url = model.url;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    
}

#pragma mark - 电话按钮点击事件
- (void)phoneButtonAction {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://4008823548"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
}

#pragma mark - 报名按钮点击事件
- (void)enrollButtonAction {
    MY_EnrollController *enrollVC = [[MY_EnrollController alloc] init];
    [self.navigationController pushViewController:enrollVC animated:YES];
}

@end
