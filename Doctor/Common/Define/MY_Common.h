//
//  MY_Common.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#ifndef MY_Common_h
#define MY_Common_h
// 屏幕宽高
#define MY_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define MY_ScreenHeight [UIScreen mainScreen].bounds.size.height
// 获得RGB颜色
#define MY_Color [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 系统版本号
#define MY_CURRENT_SYSTEM_VERSION       [[[UIDevice currentDevice] systemVersion] floatValue]

// 自定义Log
#ifdef DEBUG
#define MY_Log(...) NSLog(__VA_ARGS__)
#else
#define MY_Log(...)
#endif

// 是否为4或4s
#define MY_Iphone4 ([UIScreen mainScreen].bounds.size.height == 480)
// 是否为5或5s
#define MY_Iphone5 ([UIScreen mainScreen].bounds.size.height == 568)

// 统一背景色
#define MY_GlobalBg MY_Color(240, 240, 240)

// 设置字体大小
#define MY_Font(num)     [UIFont systemFontOfSize:num]
#define MY_BoldFont(num) [UIFont boldSystemFontOfSize:num]

//状态栏高度
#define MY_STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//nav bar高度
#define MY_NAVBAR_HEIGHT    44
//状态栏和nav bar的高度和
#define MY_APP_STATUS_NAVBAR_HEIGHT    (MY_STATUS_HEIGHT + MY_NAVBAR_HEIGHT)

// 设备ID
#define MY_CURRENT_DEVICE_ID [[UIDevice currentDevice] identifierForVendor].UUIDString

// APP版本号
#define MY_APP_VERSION     [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]


#endif /* MY_Common_h */
