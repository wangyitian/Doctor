//
//  MY_TabBarButton.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MY_BadgeButton.h"
@interface MY_TabBarButton : UIButton

@property (nonatomic, strong) UITabBarItem *tabBarItem;
@property (nonatomic, weak) MY_BadgeButton *badgeButton;
@end
