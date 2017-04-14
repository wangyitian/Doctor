//
//  MY_TabBar.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MY_TabBar;
@protocol MY_TabBarDelegate <NSObject>

- (void)tabBar:(MY_TabBar*)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to;
@end

@interface MY_TabBar : MY_View
@property (nonatomic, weak) id<MY_TabBarDelegate> delegate;

- (void)addTabBarButtonWithTabBarItem:(UITabBarItem*)tabBarItem;
@end
