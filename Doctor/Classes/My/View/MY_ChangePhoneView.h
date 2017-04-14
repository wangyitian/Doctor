//
//  MY_ChangePhoneView.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/2.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ValidateBlock)(NSString *phone);
typedef void(^ConfirmBlcok)(NSString *phone, NSString*validate);
@interface MY_ChangePhoneView : MY_View
@property (nonatomic, copy) ValidateBlock validateBlcok;
@property (nonatomic, copy) ConfirmBlcok confirmBlock;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *validateTextField;
@property (nonatomic, strong) UIButton *validateButton;
@property (nonatomic, strong) NSTimer *timer;
- (void)timerFire;
@end
