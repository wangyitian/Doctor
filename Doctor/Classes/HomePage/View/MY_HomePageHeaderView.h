//
//  MY_HomePageHeaderView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/27.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ButtonBlock)(NSInteger index);
@interface MY_HomePageHeaderView : UIView
@property (nonatomic, copy) ButtonBlock buttonBlock;
@end
