//
//  MY_ForgetPWDView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/18.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ValidateBlock)(NSString *account);
typedef void(^ConfirmBlock)(NSString *account, NSString *pwd, NSString*confirmPwd, NSString *validate);
@interface MY_ForgetPWDView : MY_View
@property (nonatomic, copy) ValidateBlock validateBlock;
@property (nonatomic, copy) ConfirmBlock confirmBlock;
@end
