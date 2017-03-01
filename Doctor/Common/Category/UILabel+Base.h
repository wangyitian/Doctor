//
//  UILabel+Base.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/1.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Base)
- (CGFloat)getLabelHeightWithSpaceHeight:(CGFloat)spaceHeight withFont:(CGFloat)font withStr:(NSString*)str withTextColor:(UIColor*)textColor withLabelWidth:(CGFloat)width;
@end
