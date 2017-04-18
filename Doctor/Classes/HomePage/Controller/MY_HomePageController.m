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
@interface MY_HomePageController () <UISearchBarDelegate>
@property (nonatomic, weak) MY_HomePageHeaderView *headerView;
@end

@implementation MY_HomePageController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavBar];
    [self setupUI];
    [self addHeaderRefresh:YES footerRefresh:YES];
    [self loadMore:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 网络请求
- (void)loadMore:(BOOL)loadMore {
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [model getDataWithURL:@"" paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        
    }];
    
    MY_RequestModel *model1 = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter1 = [NSMutableDictionary dictionary];
    [model1 getDataWithURL:@"" paramter:paramter1 success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        
    }];
}

#pragma mark - 上拉加载下拉刷新
- (void)headerRereshing {
//    [self loadMore:NO];
    
}

- (void)footerRereshing {
    [self loadMore:YES];
}

#pragma mark - 自定义导航栏
- (void)initNavBar {
    [self setTitle:@"美域医生" isBackButton:NO rightBttonName:@"患者推荐" rightImageName:nil];
}

#pragma mark - UI
- (void)setupUI {
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    
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

@end
