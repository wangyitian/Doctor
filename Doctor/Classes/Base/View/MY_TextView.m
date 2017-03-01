//
//  MY_TextView.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/1.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_TextView.h"

@interface MY_TextView ()
@property (nonatomic, weak) UILabel *placeholderLabel;
@end
@implementation MY_TextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.backgroundColor = [UIColor clearColor];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        self.myPlaceholderColor = [UIColor lightGrayColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange {
    self.placeholderLabel.hidden = self.hasText;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderLabel.top = 8;
    self.placeholderLabel.left = 5;
    self.placeholderLabel.width = self.width - self.placeholderLabel.left*2;
    
    CGSize maxSize = CGSizeMake(self.placeholderLabel.width, MAXFLOAT);
    self.placeholderLabel.height = [self.myPlaceholder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
}

- (void)setMyPlaceholder:(NSString *)myPlaceholder {
    _myPlaceholder = [myPlaceholder copy];
    self.placeholderLabel.text = myPlaceholder;
    [self setNeedsLayout];
}

- (void)setMyPlaceholderColor:(UIColor *)myPlaceholderColor {
    _myPlaceholderColor = myPlaceholderColor;
    self.placeholderLabel.textColor = myPlaceholderColor;
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self textDidChange];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
}

@end
