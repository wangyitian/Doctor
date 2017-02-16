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
@property (nonatomic, copy) LoginSuccessedBlock loginSuccessedBlock;
@property (nonatomic, strong) UIImageView *navBar;
- (void)setTitle:(NSString*)title isBackButton:(BOOL)isBackButton rightBttonName:(NSString*)rightBttonName rightImageName:(NSString*)rightImageName;

@end
