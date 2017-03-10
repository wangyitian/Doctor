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
//    self.interactivePopGestureRecognizer.delegate = self;
//    self.interactivePopGestureRecognizer.enabled = YES;
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

-(UIStatusBarStyle)preferredStatusBarStyle {
    return [[self.viewControllers lastObject] preferredStatusBarStyle];
}

@end
