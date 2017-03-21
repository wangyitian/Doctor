//
//  MY_SearchController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/21.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_SearchController.h"
#import "HXSearchBar.h"
#import "MY_HotSearchView.h"
@interface MY_SearchController () <UISearchBarDelegate>

@end

@implementation MY_SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavBar];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 自定义导航栏
- (void)initNavBar {
    self.navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_APP_STATUS_NAVBAR_HEIGHT)];
    self.navBar.backgroundColor = [MY_Util setColorWithInt:0xffffff];
    self.navBar.userInteractionEnabled = YES;
    [self.view addSubview:self.navBar];
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_STATUS_HEIGHT)];
    statusView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.navBar addSubview:statusView];
    
    HXSearchBar *searchBar = [[HXSearchBar alloc] initWithFrame:CGRectMake(12, 27, MY_ScreenWidth - 12 - 55 + 8, 30)];
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
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[MY_Util setColorWithInt:0x999999] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = MY_Font(14);
    cancelButton.frame = CGRectMake(searchBar.right, searchBar.top, 33, searchBar.height);
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:cancelButton];
}

- (void)setupUI {
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    MY_HotSearchView *hotSearchView = [[MY_HotSearchView alloc] initWithFrame:self.tableView.bounds];
    hotSearchView.dataArray = [NSArray arrayWithObjects:@"阿斯顿飞",@"水淀粉",@"地方",@"发生的",@"阿迪感动",@"舒服的",@"电风扇",@"水淀粉",@"水淀粉 是",@"是谁非", nil];
    hotSearchView.hotSearchBlock = ^(NSString *search) {
    
    };
    [self.tableView addSubview:hotSearchView];
}

- (void)cancelAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
