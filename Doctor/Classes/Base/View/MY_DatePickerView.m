//
//  MY_DatePickerView.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_DatePickerView.h"
@interface MY_DatePickerView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) NSString *selectedDate;
@end
@implementation MY_DatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }
    return self;
}

- (void)setupUI {
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 260));
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[MY_Util setColorWithInt:0x999999] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = MY_Font(14);
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = 2;
    cancelButton.layer.borderColor = [MY_Util setColorWithInt:0x999999].CGColor;
    cancelButton.layer.borderWidth = 1;
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@10);
        make.top.mas_equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(56, 26));
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = MY_Font(14);
    confirmButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 2;
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(cancelButton);
        make.right.mas_equalTo(mainView).offset(-10);
        make.top.mas_equalTo(cancelButton);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x68d6a7];
    [mainView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cancelButton.mas_right);
        make.right.mas_equalTo(confirmButton.mas_left);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(cancelButton);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [mainView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(mainView);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 0.5));
        make.top.mas_equalTo(@44);
    }];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSDateFormatter *formatter_minDate = [[NSDateFormatter alloc] init];
    [formatter_minDate setDateFormat:@"yyyy-MM-dd"];
    NSDate *minDate = [formatter_minDate dateFromString:@"2004-01-01"];
    datePicker.minimumDate = minDate;
    
    NSDateFormatter *formatter_maxDate = [[NSDateFormatter alloc] init];
    [formatter_maxDate setDateFormat:@"yyyy-MM-dd"];
    NSDate *maxDate = [formatter_minDate dateFromString:@"2050-01-01"];
    datePicker.maximumDate = maxDate;
    
    datePicker.date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.selectedDate = [dateFormatter stringFromDate:[NSDate date]];
    
    [datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [mainView addSubview:datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 217));
        make.left.mas_equalTo(mainView);
        make.bottom.mas_equalTo(mainView);
    }];
}

- (void)datePickerChanged:(UIDatePicker*)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.selectedDate = [dateFormatter stringFromDate:datePicker.date];
}

- (void)cancelButtonAction {
    [self removeFromSuperview];
}

- (void)confirmButtonAction {
    if (self.selectedDate.length) {
        if (self.selectDateBlock) {
            self.selectDateBlock(self.selectedDate);
            [self removeFromSuperview];
        }
    }
}

@end
