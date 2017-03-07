//
//  MY_CollegeHeaderView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/27.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeaderButtonBlock)(NSInteger index);

@interface MY_CollegeHeaderView : UIView
@property (nonatomic, copy) HeaderButtonBlock headerButtonBlock;
@end
