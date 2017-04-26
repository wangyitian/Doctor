//
//  MY_HomePageController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_HomePageController.h"
#import "HXSearchBar.h"
#import "MY_SearchController.h"
#import "MY_RecommendController.h"
#import "MY_HomePageHeaderView.h"
#import "MY_CourseCustomedController.h"
#import "MY_CourseListController.h"
#import "MY_CourseSegmentController.h"
#import "MY_PublishController.h"
#import "MY_CourseModel.h"
#import "MY_CourseCell.h"
#import "MY_TrainRecordModel.h"
#import "MY_TrainRecordCell.h"
#import "MY_ExperienceModel.h"
#import "MY_ExperienceCell.h"
#import "MY_BaseWebController.h"
#import "MY_CourseWebController.h"
@interface MY_HomePageController () <UISearchBarDelegate, MY_ExperienceCellDelegate>
@property (nonatomic, weak) MY_HomePageHeaderView *headerView;
@property (nonatomic, strong) NSDictionary *response;
@property (nonatomic, assign) NSInteger sectionIndex;
@end

@implementation MY_HomePageController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    [self setupUI];
    [self addHeaderRefresh:YES footerRefresh:NO];
    [self loadMore:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 网络请求
- (void)loadMore:(BOOL)loadMore {
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:[MY_Util getUid] forKey:@"uid"];
    [model getDataWithURL:MY_API_HOMEPAGE paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
//        [self.dataSource removeAllObjects];
        self.response = dic;
        self.headerView.imageArray = self.response[@"adver"];

        self.headerView.sectionBlock(self.sectionIndex);
    }];
}

#pragma mark - 上拉加载下拉刷新
- (void)headerRereshing {
    [self loadMore:NO];
    
}

#pragma mark - 自定义导航栏
- (void)initNavBar {
    [self setTitle:@"美域医生" isBackButton:NO rightBttonName:@"患者推荐" rightImageName:nil];
}

#pragma mark - UI
- (void)setupUI {
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 49, 0);
    
    MY_HomePageHeaderView *headerView = [[MY_HomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    headerView.buttonBlock = ^(NSInteger index) {
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
    headerView.sectionBlock = ^(NSInteger index) {
        self.sectionIndex = index;
        [self.dataSource removeAllObjects];
        if (index == 0) {
            NSArray *courses = [NSArray arrayWithArray:[self.response arrayWithKey:@"kecheng"]];
            NSMutableArray *mutCourses = [NSMutableArray array];
            for (NSDictionary *courseDic in courses) {
                MY_CourseModel *model = [[MY_CourseModel alloc] initWithDictionary:courseDic];
                [mutCourses addObject:model];
            }
            [self.dataSource addObject:mutCourses];
        } else if (index == 1) {
            NSArray *courses = [NSArray arrayWithArray:[self.response arrayWithKey:@"news"]];
            NSMutableArray *mutCourses = [NSMutableArray array];
            for (NSDictionary *courseDic in courses) {
                MY_TrainRecordModel *model = [[MY_TrainRecordModel alloc] initWithDictionary:courseDic];
                [mutCourses addObject:model];
            }
            [self.dataSource addObject:mutCourses];
        } else if (index == 2) {
            NSArray *courses = [NSArray arrayWithArray:[self.response arrayWithKey:@"xinde"]];
            NSMutableArray *mutCourses = [NSMutableArray array];
            for (NSDictionary *courseDic in courses) {
                MY_ExperienceModel *model = [[MY_ExperienceModel alloc] initWithDictionary:courseDic];
                [mutCourses addObject:model];
            }
            [self.dataSource addObject:mutCourses];
        }
        [self.tableView reloadData];
    };
    
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [publishButton setImage:[UIImage imageNamed:@"publish"] forState:UIControlStateNormal];
    publishButton.frame = CGRectMake(MY_ScreenWidth-50-25, MY_ScreenHeight-49-25-50, 50, 50);
    [publishButton addTarget:self action:@selector(publishButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishButton];
}

#pragma mark - 右导航按钮点击事件
- (void)rightButtonAction {
    MY_RecommendController *recommendVC = [[MY_RecommendController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}

- (void)publishButtonAction {
    MY_PublishController *publishVC = [[MY_PublishController alloc] init];
    [self.navigationController pushViewController:publishVC animated:YES];
}

- (void)zanActionWithIndexPath:(NSIndexPath *)indexPath isZan:(NSString *)isZan{
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:[MY_Util getUid] forKey:@"uid"];
    [paramter setObject:isZan forKey:@"did"];
    [paramter setObject:((MY_ExperienceModel*)[[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row]).experienceId forKey:@"id"];
    [model getDataWithURL:MY_API_ZAN paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        [self presentAlertWithMessage:dic[@"message"] ConfirmAction:nil completion:nil];
        MY_ExperienceCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        cell.zanBlock();
    }];
}

- (void)seeAllActionWithIndexPath:(NSIndexPath *)indexPath {
    
    ((MY_ExperienceModel*)[[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row]).isOpen = !((MY_ExperienceModel*)[[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row]).isOpen;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    if ([object isKindOfClass:[MY_CourseModel class]]) {
        return [MY_CourseCell class];
    } else if ([object isKindOfClass:[MY_TrainRecordModel class]]) {
        return [MY_TrainRecordCell class];
    } else if ([object isKindOfClass:[MY_ExperienceModel class]]) {
        return [MY_ExperienceCell class];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row] isKindOfClass:[MY_CourseModel class]]) {
        MY_CourseModel *model = [[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row];
        MY_CourseWebController *webVC = [[MY_CourseWebController alloc] init];
        webVC.url = [NSString stringWithFormat:@"%@%@",MY_WEB_COURSEDETAIL,model.courseId];
        [self.navigationController pushViewController:webVC animated:YES];
    } else if ([[[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row] isKindOfClass:[MY_TrainRecordModel class]]) {
        MY_TrainRecordModel *model = [[self.dataSource objectAtIndex:0] objectAtIndex:indexPath.row];
        MY_BaseWebController *webVC = [[MY_BaseWebController alloc] init];
        webVC.url = [NSString stringWithFormat:@"%@%@",MY_WEB_TRAINING,model.trainId];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

@end
