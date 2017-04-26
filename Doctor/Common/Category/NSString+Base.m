//
//  NSString+Base.m
//  YiMeiBusiness
//
//  Created by 刘玉娇 on 15/12/8.
//  Copyright © 2015年 Xiaolinxiaoli. All rights reserved.
//

#import "NSString+Base.h"

@implementation NSString (Base)

- (CGFloat)getHeightWithSpaceHeight:(CGFloat)spaceHeight withFont:(CGFloat)font withStr:(NSString *)str withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = spaceHeight; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

- (BOOL)isEmptyStr {
    if (self && [self isKindOfClass:[NSString class]] && ![self isEqualToString:@""] ) {
        return NO;
    }
    return YES;
}

- (BOOL)isEmptyOrZero {
    if (self && [self isKindOfClass:[NSString class]] && ![self isEqualToString:@""] && self.floatValue != 0) {
        return NO;
    }
    return YES;
}

- (NSString*)floatStr {
    return [NSString stringWithFormat:@"%.1f", self.floatValue];
}

-(NSString*)getStrFromString:(NSString*)startStr toString:(NSString*)endString {
    NSRange embedTagStartRange = [self rangeOfString:startStr];
    NSString* embedTagContent;
    
    if ([endString isEqualToString:@""] || endString == nil) {
        embedTagContent = [self substringFromIndex:embedTagStartRange.location+embedTagStartRange.length];
        return embedTagContent;
    }
    NSRange embedTagEndRange = [self rangeOfString:endString];
    if (embedTagStartRange.length > 0 && embedTagEndRange.length > 0) {
        NSUInteger embedTagStartLocation = embedTagStartRange.location + startStr.length;
        
        NSRange embedTagRange = NSMakeRange(embedTagStartLocation, embedTagEndRange.location - embedTagStartLocation);
        embedTagContent = [self substringWithRange:embedTagRange];
    }
    return embedTagContent;
}

- (CGSize)sizeWithFont:(UIFont *)font andSize:(CGSize)size {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [self boundingRectWithSize:size
                                          options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    
    return retSize;
}

- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithAttributes:@{NSFontAttributeName:font}];
}

- (BOOL)isPhoneNum {
    NSString *regex = @"((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isPhoneNum = [pred evaluateWithObject:self];
    return isPhoneNum;
}

@end
