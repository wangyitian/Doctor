//
//  MY_ENUM.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/16.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#ifndef MY_ENUM_h
#define MY_ENUM_h

/**
 *  进入登陆的类型
 */
typedef NS_ENUM(NSInteger, MY_EnterLoginType) {
    /**
     *  未登陆点击 我的tabbar
     */
    MY_EnterLoginTypeTabbarMy = 0,
    /**
     *  被登出 － 另一设备登陆
     */
    MY_EnterLoginTypeSingleLoginOut,
    /**
     *    默认
     */
    MY_EnterLoginTypeDefaut
};
#endif /* MY_ENUM_h */
