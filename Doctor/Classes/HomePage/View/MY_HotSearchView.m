//
//  MY_HotSearchView.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_HotSearchView.h"
#define TAG_FOR_BUTTON  2000
@interface MY_HotSearchView ()
@property (nonatomic, strong) UIView *hotDataView;
@end
@implementation MY_HotSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 8 + MY_APP_STATUS_NAVBAR_HEIGHT, 100, 15)];
    titleLabel.font = MY_Font(15);
    titleLabel.text = @"热门搜索";
    titleLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self addSubview:titleLabel];
    
    self.hotDataView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLabel.bottom+5, MY_ScreenWidth, 0)];
    [self addSubview:self.hotDataView];
    
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    CGFloat buttonX = 20;
    CGFloat buttonY = 10;
    CGFloat buttonH = 26;
    
    for (int i = 0; i < dataArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:dataArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(12);
        button.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 2;
        
        CGFloat buttonW = [dataArray[i] sizeWithAttributes:@{NSFontAttributeName:MY_Font(12)}].width + 16;
        
        if (buttonW + buttonX + 20 > MY_ScreenWidth) {
            buttonX = 20;
            buttonY = buttonY + 26 + 10;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        buttonX = buttonX + buttonW + 20;
        
        button.tag = TAG_FOR_BUTTON + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.hotDataView addSubview:button];
        
        self.hotDataView.height = button.bottom;
    }
}

- (void)buttonAction:(UIButton*)button {
    if (self.hotSearchBlock) {
        self.hotSearchBlock(self.dataArray[button.tag-TAG_FOR_BUTTON]);
    }
}

@end
