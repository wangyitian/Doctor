//
//  MY_BadgeButton.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BadgeButton.h"

@implementation MY_BadgeButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundColor:[UIColor redColor]];
        self.titleLabel.font = MY_Font(11);
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 9;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = [badgeValue copy];
    
    if (badgeValue.length) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:UIControlStateNormal];
        CGRect frame = self.frame;
        CGFloat badgeH = 18;
        CGFloat badgeW = badgeValue.length*10+10;
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
    } else {
        self.hidden = YES;
    }
}

@end
