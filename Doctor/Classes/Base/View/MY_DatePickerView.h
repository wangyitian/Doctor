//
//  MY_DatePickerView.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectDateBlock)(NSString *date);
@interface MY_DatePickerView : UIView
@property (nonatomic, copy) SelectDateBlock selectDateBlock;
@end
