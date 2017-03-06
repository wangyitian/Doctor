//
//  MY_TabController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_TabController.h"
#import "MY_TabBar.h"
#import "MY_NavigationController.h"
#import "MY_BaseController.h"
#import "MY_LoginController.h"
#import "MY_HomePageController.h"
#import "MY_CollegeController.h"
#import "MY_MessageController.h"
#import "MY_MyController.h"
//#import "MY_PlayVedioController.h"
@interface MY_TabController () <MY_TabBarDelegate>
@property (nonatomic, weak) MY_TabBar *customTabBar;
@end

@implementation MY_TabController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
    
    [self setupChildVCs];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:[UIControl class]]) {
            [view removeFromSuperview];
        }
    }
}

- (void)setupTabBar {
    MY_TabBar *tabBar = [[MY_TabBar alloc] initWithFrame:self.tabBar.bounds];
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];
    self.customTabBar = tabBar;
}

- (void)setupChildVCs {
    [self setupChildViewController:[[MY_HomePageController alloc] init] title:@"首页" imageName:@"tab_homePage" selectedImageName:@"tab_homePage_s"];
    [self setupChildViewController:[[MY_CollegeController alloc] init] title:@"学院" imageName:@"tab_college" selectedImageName:@"tab_college_s"];
//    [self setupChildViewController:[[MY_PlayVedioController alloc] init] title:@"直播" imageName:@"tab_vedio" selectedImageName:@"tab_vedio_s"];
    [self setupChildViewController:[[MY_MessageController alloc] init] title:@"消息" imageName:@"tab_message" selectedImageName:@"tab_message_h"];
    [self setupChildViewController:[[MY_MyController alloc] init] title:@"我的" imageName:@"tab_my" selectedImageName:@"tab_my_s"];
}

- (void)tabBar:(MY_TabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to {
    self.selectedIndex = to;
}

- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 2.包装一个导航控制器
    MY_NavigationController *nav = [[MY_NavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
}

@end
