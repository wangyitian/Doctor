//
//  MY_MyHeaderView.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PersonalDataBlock)();
@interface MY_MyHeaderView : UIView
@property (nonatomic, copy) PersonalDataBlock personalDataBlock;
@end
