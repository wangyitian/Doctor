//
//  MY_RegisterView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/18.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ValidateBlock)(NSString *account);
typedef void(^ConfirmBlock)(NSString *account, NSString *pwd, NSString*validate);
@interface MY_RegisterView : UIView
@property (nonatomic, strong) ValidateBlock validateBlock;
@property (nonatomic, strong) ConfirmBlock confirmBlock;
@end
