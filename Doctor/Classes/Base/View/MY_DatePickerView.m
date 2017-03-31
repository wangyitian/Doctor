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
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom-260, MY_ScreenWidth, 260)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:mainView];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(10, 10, 56, 26);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[MY_Util setColorWithInt:0x999999] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = MY_Font(14);
    cancelButton.layer.masksToBounds = YES;
    cancelButton.layer.cornerRadius = 2;
    cancelButton.layer.borderColor = [MY_Util setColorWithInt:0x999999].CGColor;
    cancelButton.layer.borderWidth = 1;
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:cancelButton];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmButton.frame = CGRectMake(MY_ScreenWidth-10-cancelButton.width, cancelButton.top, cancelButton.width, cancelButton.height);
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = MY_Font(14);
    confirmButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 2;
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:confirmButton];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(cancelButton.right, 0, confirmButton.left-cancelButton.right, 20)];
    self.titleLabel.centerY = cancelButton.centerY;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x68d6a7];
    [mainView addSubview:self.titleLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(mainView.left, 44, MY_ScreenWidth, 0.5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [mainView addSubview:line];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(mainView.left, mainView.height-217, MY_ScreenWidth, 217)];
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
