//
//  MY_BeautyView.m
//  Doctor
//
//  Created by 王翼天 on 2017/7/11.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BeautyView.h"

@interface MY_BeautyView ()
@property (nonatomic, strong) UISlider *beautyFilterSlider;
@property (nonatomic, strong) UISlider *whiteningFilterSlider;

@property (nonatomic, assign) CGFloat beautyFilterValue;
@property (nonatomic, assign) CGFloat whiteningFilterValue;

@end

@implementation MY_BeautyView

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(20, MY_ScreenHeight-70-20-100, MY_ScreenWidth-20*2, 100);
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *beautyFilterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 30)];
    beautyFilterLabel.text = @"美颜";
    beautyFilterLabel.textColor = [MY_Util setColorWithInt:0x999999];
    beautyFilterLabel.font = MY_Font(15);
    [self addSubview:beautyFilterLabel];
    
    self.beautyFilterSlider = [[UISlider alloc] initWithFrame:CGRectMake(beautyFilterLabel.right, 5, self.width-10-beautyFilterLabel.right, 40)];
    self.beautyFilterSlider.maximumValue = 9;
    self.beautyFilterSlider.minimumValue = 0;
    self.beautyFilterSlider.thumbTintColor = [MY_Util setColorWithInt:0x68d6a7];
    self.beautyFilterSlider.minimumTrackTintColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.beautyFilterSlider addTarget:self action:@selector(beautyFilterSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.beautyFilterSlider];
    
    UILabel *whiteningFilterLAbel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50+10, 40, 30)];
    whiteningFilterLAbel.text = @"美白";
    whiteningFilterLAbel.textColor = [MY_Util setColorWithInt:0x999999];
    whiteningFilterLAbel.font = MY_Font(15);
    [self addSubview:whiteningFilterLAbel];
    
    self.whiteningFilterSlider = [[UISlider alloc] initWithFrame:CGRectMake(whiteningFilterLAbel.right, 55, self.width-10-whiteningFilterLAbel.right, 40)];
    self.whiteningFilterSlider.maximumValue = 9;
    self.whiteningFilterSlider.minimumValue = 0;
    self.whiteningFilterSlider.thumbTintColor = [MY_Util setColorWithInt:0x68d6a7];
    self.whiteningFilterSlider.minimumTrackTintColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.whiteningFilterSlider addTarget:self action:@selector(whiteningFilterSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.whiteningFilterSlider];
}

- (void)beautyFilterSliderValueChanged:(UISlider*)slider {
    
    self.beautyFilterValue = slider.value;
    
    if (self.beautyFilterBlock) {
        self.beautyFilterBlock(self.beautyFilterValue, self.whiteningFilterValue);
    }
}

- (void)whiteningFilterSliderValueChanged:(UISlider*)slider {
    
    self.whiteningFilterValue = slider.value;
    
    if (self.whiteningFilterBlock) {
        self.whiteningFilterBlock(self.beautyFilterValue, self.whiteningFilterValue);
    }
}

@end
