//
//  MY_BeautyView.h
//  Doctor
//
//  Created by 王翼天 on 2017/7/11.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BeautyFilterBlock)(int beautyFilterValue, int whiteningFilterValue);
typedef void(^WhiteningFilterBlock)(int beautyFilterValue, int whiteningFilterValue);

@interface MY_BeautyView : MY_View
@property (nonatomic, copy) BeautyFilterBlock beautyFilterBlock;
@property (nonatomic, copy) WhiteningFilterBlock whiteningFilterBlock;
@end
