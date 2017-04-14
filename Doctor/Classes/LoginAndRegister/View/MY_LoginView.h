//
//  MY_LoginView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/18.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LoginButtonClick)(NSString*account, NSString*pwd);
typedef void(^ForgetButtonClick)();
typedef void(^RegisterButtonClick)();
typedef void(^WechatButtonBlock)();

@interface MY_LoginView : MY_View
@property (nonatomic, copy) LoginButtonClick loginButtonBlock;
@property (nonatomic, copy) ForgetButtonClick forgetButtonClick;
@property (nonatomic, copy) RegisterButtonClick registerButtonClick;
@property (nonatomic, copy) WechatButtonBlock wechatButtonBlock;
@end
