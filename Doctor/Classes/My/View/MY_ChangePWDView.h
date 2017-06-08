//
//  MY_ChangePWDView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/22.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ValidateBlock)(NSString *phone);
typedef void(^ConfirmBlock)(NSString *phone, NSString *validate, NSString *pwd);
@interface MY_ChangePWDView : MY_View
@property (nonatomic, copy) ValidateBlock validateBlock;
@property (nonatomic, copy) ConfirmBlock confirmBlock;
@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, assign) BOOL isRegister;


- (void)timerFire;
@end
