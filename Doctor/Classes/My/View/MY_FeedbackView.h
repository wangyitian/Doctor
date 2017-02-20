//
//  MY_FeedbackView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ConfirmBlock)(NSString *suggest, NSString*phone);
@interface MY_FeedbackView : UIView
@property (nonatomic, copy) ConfirmBlock confirmBlock;
@end
