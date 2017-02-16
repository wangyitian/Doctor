//
//  MY_NavigationController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_NavigationController.h"
@interface MY_NavigationController () <UIGestureRecognizerDelegate>

@end

@implementation MY_NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UINavigationBar *bar = [UINavigationBar appearance];
//    // 去掉bar下面的底线
//    bar.barStyle = UIBaselineAdjustmentNone;
////    [bar setBackgroundImage:[UIImage imageNamed:@"Nav_background"] forBarMetrics:UIBarMetricsDefault];
//    bar.backgroundColor = [UIColor redColor];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:MY_Color(70, 71, 75), NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:17.0], NSFontAttributeName, nil]];
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count) {
        viewController.hidesBottomBarWhenPushed = self.viewControllers.count;
    }
    [super pushViewController:viewController animated:animated];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return [[self.viewControllers lastObject] preferredStatusBarStyle];
}

@end
