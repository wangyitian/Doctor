//
//  MY_RegisterController.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseScrollController.h"

@interface MY_RegisterController : MY_BaseScrollController
@property (nonatomic, assign) BOOL isWechat;
@property (nonatomic, strong) NSString *wechatUid;
@property (nonatomic, strong) NSString *wechatOpenid;
@property (nonatomic, strong) NSString *wechatName;
@property (nonatomic, strong) NSString *wechatIconUrl;
@property (nonatomic, strong) NSString *wechatAccessToken;
@property (nonatomic, strong) NSString *wechatRefreshToken;
@end
