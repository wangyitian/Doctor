//
//  MY_BaseController.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MY_RequestModel.h"
typedef void(^LoginSuccessedBlock)();
@interface MY_BaseController : UIViewController <MY_RequestModelDelegate>
@property (nonatomic, copy) LoginSuccessedBlock _Nonnull loginSuccessedBlock;
@property (nonatomic, strong) UIImageView * _Nullable navBar;
@property (nonatomic, strong) UILabel * _Nullable navLabel;
@property (nonatomic, strong) NSMutableArray * _Nullable requestArray;
- (void)setTitle:(NSString*_Nullable)title isBackButton:(BOOL)isBackButton rightBttonName:(NSString*_Nullable)rightBttonName rightImageName:(NSString*_Nullable)rightImageName;
- (void)showLoading;
- (void)hideLoading;
- (void)presentAlertWithMessage:(NSString*_Nullable)message ConfirmAction:(void (^ __nullable)(UIAlertAction * _Nullable action))confirmAction completion:(void(^ __nullable)(void))completion;
@end
