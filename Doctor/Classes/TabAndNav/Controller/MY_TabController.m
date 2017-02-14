//
//  MY_TabController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_TabController.h"
#import "MY_TabBar.h"
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
    [self setupChildViewController:[[UIViewController alloc] init] title:@"first" imageName:nil selectedImageName:nil];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"second" imageName:nil selectedImageName:nil];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"third" imageName:nil selectedImageName:nil];
    [self setupChildViewController:[[UIViewController alloc] init] title:@"fourth" imageName:nil selectedImageName:nil];
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
//    if (iOS7) {
//        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    } else {
//        childVc.tabBarItem.selectedImage = selectedImage;
//    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
}

@end
