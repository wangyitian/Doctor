//
//  NSString+Base.m
//  YiMeiBusiness
//
//  Created by 刘玉娇 on 15/12/8.
//  Copyright © 2015年 Xiaolinxiaoli. All rights reserved.
//

#import "NSString+Base.h"

@implementation NSString (Base)

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

@end
