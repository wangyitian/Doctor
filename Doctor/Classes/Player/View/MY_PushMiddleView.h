//
//  MY_PushMiddleView.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LiveButtonBlock)();
@interface MY_PushMiddleView : MY_View
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UIButton *liveButton;
@property (nonatomic, strong) LiveButtonBlock liveButtonBlock;
@end
