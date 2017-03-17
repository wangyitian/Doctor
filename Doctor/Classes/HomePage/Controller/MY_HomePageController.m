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
@interface MY_HomePageController () <UISearchBarDelegate>

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
}

#pragma mark - 上拉加载下拉刷新
- (void)headerRereshing {
    [self loadMore:NO];
}

- (void)footerRereshing {
    [self loadMore:YES];
}

#pragma mark - 自定义导航栏
- (void)initNavBar {
    self.navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_APP_STATUS_NAVBAR_HEIGHT)];
    self.navBar.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    self.navBar.userInteractionEnabled = YES;
    [self.view addSubview:self.navBar];
    
    HXSearchBar *searchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(12, 27, MY_ScreenWidth - 18 - 20 - 17, 30)];
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.delegate = self;
    //光标颜色
    searchBar.cursorColor = [MY_Util setColorWithInt:0x68d6a7];
    //TextField
    searchBar.searchBarTextField.layer.cornerRadius = 4;
    searchBar.searchBarTextField.layer.masksToBounds = YES;
    searchBar.searchBarTextField.layer.borderColor = [MY_Util setColorWithInt:0xababab].CGColor;
    searchBar.searchBarTextField.layer.borderWidth = 1.0;
    
    //清除按钮图标
    searchBar.clearButtonImage = [UIImage imageNamed:@"demand_delete"];
    
    //去掉取消按钮灰色背景
    searchBar.hideSearchBarBackgroundImage = YES;
    
    [self.navBar addSubview:searchBar];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"homePage_recommend"] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(MY_ScreenWidth - 20 - 17 - 5, 29, 27, 27);
    [rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:rightButton];
}

#pragma mark - UI
- (void)setupUI {
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    
    MY_HomePageHeaderView *headerView = [[MY_HomePageHeaderView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    
    headerView.buttonBlock = ^(NSInteger index) {
        NSMutableArray *vcArray = [NSMutableArray array];
        if (index == 4) {
            MY_CourseCustomedController *vc = [[MY_CourseCustomedController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            NSArray *types = nil;
            if (index == 1) {
                types = [NSArray arrayWithObjects:@"全部",@"临床研修",@"医技培训",@"专科特训", nil];
            } else if (index == 2) {
                types = [NSArray arrayWithObjects:@"全部",@"美国",@"台湾",@"新加坡", nil];
            } else if (index == 3) {
                types = [NSArray arrayWithObjects:@"实验室访学", nil];
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
        }
    };
    
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - 右导航按钮点击事件
- (void)rightButtonAction {
    MY_RecommendController *recommendVC = [[MY_RecommendController alloc] init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    MY_SearchController *searchVC = [[MY_SearchController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}


@end
