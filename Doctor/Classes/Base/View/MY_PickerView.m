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
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.showsSelectionIndicator = YES;
    [mainView addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 217));
        make.left.mas_equalTo(mainView);
        make.bottom.mas_equalTo(mainView);
    }];
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

//- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//    label.textColor = [MY_Util setColorWithInt:0x68d6a7];
//    label.text = self.dataSource[row];
//    return label;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedValue = self.dataSource[row];
}

- (void)cancelButtonAction {
    [self removeFromSuperview];
}

- (void)confirmButtonAction {
    if (self.confirmBlock) {
        self.confirmBlock(self.selectedValue);
    }
}

@end
