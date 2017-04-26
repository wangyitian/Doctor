//
//  NSString+Base.h
//  YiMeiBusiness
//
//  Created by 刘玉娇 on 15/12/8.
//  Copyright © 2015年 Xiaolinxiaoli. All rights reserved.
//



@interface NSString (Base)

/**
 *  判断是否为空字符串
 *
 *  @return YES(空字符串) NO(非空字符串)
 */
- (BOOL)isEmptyStr;


- (NSString*)getStrFromString:(NSString*)startStr toString:(NSString*)endString;

- (CGSize)sizeWithFont:(UIFont *)font andSize:(CGSize)size;

- (CGSize)sizeWithFont:(UIFont *)font;

- (BOOL)isEmptyOrZero;

- (NSString*)floatStr;

- (BOOL)isPhoneNum;
- (CGFloat)getHeightWithSpaceHeight:(CGFloat)spaceHeight withFont:(CGFloat)font withStr:(NSString *)str withWidth:(CGFloat)width;
@end
