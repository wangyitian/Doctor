//
//  UILabel+Base.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/1.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "UILabel+Base.h"

@implementation UILabel (Base)

- (CGFloat)getLabelHeightWithSpaceHeight:(CGFloat)spaceHeight withFont:(CGFloat)font withStr:(NSString *)str withTextColor:(UIColor *)textColor withLabelWidth:(CGFloat)width{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = spaceHeight; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    if (!str) {
        str = @"";
    }
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:paraStyle};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    self.attributedText = attributeStr;
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

@end
