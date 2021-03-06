//
//  MY_PickerView.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PickerView.h"

@interface MY_PickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) NSString *selectedValue;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MY_PickerView

- (instancetype)initWithDataSource:(NSArray *)dataSource title:(NSString *)title {
    if (self = [super initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_ScreenHeight)]) {
        self.dataSource = dataSource;
        [self setupUI];
        self.titleLabel.text = title;
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-260, MY_ScreenWidth, 260)];
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
    confirmButton.frame = CGRectMake(MY_ScreenWidth-10-56, cancelButton.top, cancelButton.width, cancelButton.height);
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
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 44, MY_ScreenWidth, 0.5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [mainView addSubview:line];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, mainView.height-217, MY_ScreenWidth, 217)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [mainView addSubview:pickerView];
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    self.selectedValue = dataSource[0];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 35;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedValue = self.dataSource[row];
}

- (void)cancelButtonAction {
    [self removeFromSuperview];
}

- (void)confirmButtonAction {
    if (self.confirmBlock) {
        self.confirmBlock(self.selectedValue);
        [self removeFromSuperview];
    }
}

@end
