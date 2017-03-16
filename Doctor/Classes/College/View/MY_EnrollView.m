//
//  MY_EnrollView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_EnrollView.h"
#import "MY_DatePickerView.h"
#import "MY_PickerView.h"
@interface MY_EnrollView () <UITextViewDelegate>
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *idTextField;
@property (nonatomic, strong) NSMutableArray *passportButtonArray;
@property (nonatomic, strong) UITextField *passportIdTextField;
@property (nonatomic, strong) UILabel *validityLabel;
@property (nonatomic, strong) UITextField *roomTypeTextField;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UITextField *companyTextField;
@property (nonatomic, strong) MY_TextView *intentionTextView;
@property (nonatomic, strong) NSString *passportType;
@end
@implementation MY_EnrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.passportType = @"";
        self.passportButtonArray = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *space1 = [[UIView alloc] init];
    space1.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:space1];
    [space1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 5));
    }];
    
    UILabel *nameLabel = [self createLabelWithText:@"您的姓名"];
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(space1.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 15));
    }];
    
    self.nameTextField = [self createTextFieldWithPlaceholder:@"请输入您的姓名"];
    [self addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right);
        make.right.equalTo(self);
        make.top.equalTo(nameLabel.mas_top);
        make.height.equalTo(nameLabel.mas_height);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(6);
        make.height.mas_equalTo(@0.5);
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(15);
        make.right.mas_equalTo(self).with.offset(-6);
    }];
    
    UILabel *phoneLabel = [self createLabelWithText:@"您的电话"];
    [self addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(line1).with.offset(15);
        make.size.mas_equalTo(nameLabel);
    }];
    
    self.phoneTextField = [self createTextFieldWithPlaceholder:@"请输入您的手机号"];
    [self addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameTextField);
        make.right.equalTo(self.nameTextField);
        make.top.equalTo(phoneLabel);
        make.height.equalTo(phoneLabel);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1);
        make.top.mas_equalTo(phoneLabel.mas_bottom).with.offset(15);
        make.size.mas_equalTo(line1);
    }];
    
    UILabel *emailLabel = [self createLabelWithText:@"您的邮箱"];
    [self addSubview:emailLabel];
    [emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneLabel);
        make.top.equalTo(line2).with.offset(15);
        make.size.mas_equalTo(phoneLabel);
    }];
    
    self.emailTextField = [self createTextFieldWithPlaceholder:@"输入您的邮箱"];
    [self addSubview:self.emailTextField];
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneTextField);
        make.top.equalTo(emailLabel);
        make.size.mas_equalTo(self.phoneTextField);
    }];
    
    UIView *space2 = [[UIView alloc] init];
    space2.backgroundColor = space1.backgroundColor;
    [self addSubview:space2];
    [space2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(emailLabel.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 10));
    }];
    
    UILabel *idLabel = [self createLabelWithText:@"身份证号"];
    [self addSubview:idLabel];
    [idLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(emailLabel);
        make.top.mas_equalTo(space2.mas_bottom).with.offset(15);
        make.size.mas_equalTo(emailLabel);
    }];
    
    self.idTextField = [self createTextFieldWithPlaceholder:@"请输入您的身份证号码"];
    [self addSubview:self.idTextField];
    [self.idTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.emailTextField);
        make.top.mas_equalTo(idLabel);
        make.size.mas_equalTo(self.emailTextField);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = line2.backgroundColor;
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line2);
        make.top.mas_equalTo(idLabel.mas_bottom).with.offset(15);
        make.size.mas_equalTo(line2);
    }];
    
    UILabel *passportTypeLabel = [self createLabelWithText:@"护照类型"];
    [self addSubview:passportTypeLabel];
    [passportTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(idLabel);
        make.top.mas_equalTo(line3).with.offset(15);
        make.size.mas_equalTo(idLabel);
    }];
    
    NSArray *buttonTitles = [NSArray arrayWithObjects:@" 因私",@" 因公", nil];
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(13);
        button.tag = 3000 + i;
        [button setImage:[UIImage imageNamed:@"option"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"option_s"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(passportTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.passportButtonArray addObject:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(@(100+100*i));
            make.top.mas_equalTo(line3).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 35));
        }];
    }
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = line3.backgroundColor;
    [self addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line3);
        make.top.mas_equalTo(passportTypeLabel.mas_bottom).with.offset(15);
        make.size.mas_equalTo(line3);
    }];
    
    UILabel *passportIdLabel = [self createLabelWithText:@"护照号码"];
    [self addSubview:passportIdLabel];
    [passportIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passportTypeLabel);
        make.top.mas_equalTo(line4).with.offset(15);
        make.size.mas_equalTo(passportTypeLabel);
    }];
    
    self.passportIdTextField = [self createTextFieldWithPlaceholder:@"请输入您的护照号码"];
    [self addSubview:self.passportIdTextField];
    [self.passportIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.idTextField);
        make.top.mas_equalTo(line4).with.offset(15);
        make.size.mas_equalTo(self.idTextField);
    }];
    
    UIView *line5 = [[UIView alloc] init];
    line5.backgroundColor = line4.backgroundColor;
    [self addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line4);
        make.top.mas_equalTo(passportIdLabel.mas_bottom).with.offset(15);
        make.size.mas_equalTo(line4);
    }];
    
    UIView *validityView = [[UIView alloc] init];
    UITapGestureRecognizer *validityTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectValidity)];
    [validityView addGestureRecognizer:validityTap];
    [self addSubview:validityView];
    [validityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(line5);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 45));
    }];
    
    UILabel *titleLabel = [self createLabelWithText:@"请选择护照有效期"];
    [validityView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@20);
        make.top.mas_equalTo(@15);
        make.size.mas_equalTo(CGSizeMake(130, 15));
    }];
    
    self.validityLabel = [[UILabel alloc] init];
    self.validityLabel.textColor = [MY_Util setColorWithInt:0xbbbbbb];
    self.validityLabel.font = MY_Font(12);
    [validityView addSubview:self.validityLabel];
    [self.validityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 13));
        make.centerY.mas_equalTo(titleLabel);
    }];
    
    UIImageView *arrow1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [validityView addSubview:arrow1];
    [arrow1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(7, 7));
        make.right.mas_equalTo(validityView).with.offset(-20);
        make.centerY.mas_equalTo(titleLabel);
    }];
    
    UIView *space3 = [[UIView alloc] init];
    space3.backgroundColor = space2.backgroundColor;
    [self addSubview:space3];
    [space3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(validityView.mas_bottom);
        make.size.mas_equalTo(space2);
    }];
    
    UILabel *roomTypeLabel = [self createLabelWithText:@"科  室"];
    [self addSubview:roomTypeLabel];
    [roomTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(passportIdLabel);
        make.top.mas_equalTo(space3.mas_bottom).with.offset(15);
        make.size.mas_equalTo(passportIdLabel);
    }];
    
    self.roomTypeTextField = [self createTextFieldWithPlaceholder:@"请输入科室名称"];
    [self addSubview:self.roomTypeTextField];
    [self.roomTypeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.passportIdTextField);
        make.top.mas_equalTo(roomTypeLabel);
        make.size.mas_equalTo(self.passportIdTextField);
    }];
    
    UIView *line6 = [[UIView alloc] init];
    line6.backgroundColor = line5.backgroundColor;
    [self addSubview:line6];
    [line6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line5);
        make.size.mas_equalTo(line5);
        make.top.mas_equalTo(roomTypeLabel.mas_bottom).with.offset(15);
    }];
    
    UIView *positionView = [[UIView alloc] init];
    UITapGestureRecognizer *positionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPosition)];
    [positionView addGestureRecognizer:positionTap];
    [self addSubview:positionView];
    [positionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.top.mas_equalTo(line6);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 45));
    }];
    
    UILabel *pLabel = [self createLabelWithText:@"请选择职称"];
    [positionView addSubview:pLabel];
    [pLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(roomTypeLabel);
        make.top.mas_equalTo(@15);
        make.size.mas_equalTo(CGSizeMake(85, 15));
    }];
    
    self.positionLabel = [[UILabel alloc] init];
    self.positionLabel.font = MY_Font(12);
    self.positionLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [positionView addSubview:self.positionLabel];
    [self.positionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pLabel.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(120, 13));
        make.centerY.mas_equalTo(pLabel);
    }];
    
    UIImageView *arrow2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [positionView addSubview:arrow2];
    [arrow2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(7, 7));
        make.right.mas_equalTo(positionView).with.offset(-20);
        make.centerY.mas_equalTo(pLabel);
    }];
    
    UIView *line7 = [[UIView alloc] init];
    line7.backgroundColor = line6.backgroundColor;
    [self addSubview:line7];
    [line7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line6);
        make.size.mas_equalTo(line6);
        make.top.mas_equalTo(positionView.mas_bottom);
    }];
    
    UILabel *companyLabel = [self createLabelWithText:@"工作单位"];
    [self addSubview:companyLabel];
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(roomTypeLabel);
        make.size.mas_equalTo(roomTypeLabel);
        make.top.mas_equalTo(line7).with.offset(15);
    }];
    
    self.companyTextField = [self createTextFieldWithPlaceholder:@"请输入您的单位名称"];
    [self addSubview:self.companyTextField];
    [self.companyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.roomTypeTextField);
        make.size.mas_equalTo(self.roomTypeTextField);
        make.centerY.mas_equalTo(companyLabel);
    }];
    
    UIView *space4 = [[UIView alloc] init];
    space4.backgroundColor = space3.backgroundColor;
    [self addSubview:space4];
    [space4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(companyLabel.mas_bottom).with.offset(15);
        make.size.mas_equalTo(space3);
    }];
    
    self.intentionTextView = [[MY_TextView alloc] init];
    self.intentionTextView.font = MY_Font(12);
    self.intentionTextView.delegate = self;
    self.intentionTextView.myPlaceholderColor = [MY_Util setColorWithInt:0xcccccc];
    self.intentionTextView.myPlaceholder = @"                     请输入您想出行的地区，医院，时间等";
    [self addSubview:self.intentionTextView];
    [self.intentionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(15);
        make.top.mas_equalTo(space4.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth-30, 90));
    }];
    
    
    UILabel *intentionLabel = [self createLabelWithText:@"进修意向"];
    [self.intentionTextView addSubview:intentionLabel];
    [intentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@5);
        make.top.mas_equalTo(8);
        make.size.mas_equalTo(CGSizeMake(64, 15));
    }];

    
    UIView *space5 = [[UIView alloc] init];
    space5.backgroundColor = space4.backgroundColor;
    [self addSubview:space5];
    [space5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space4);
        make.size.mas_equalTo(space4);
        make.top.mas_equalTo(self.intentionTextView.mas_bottom);
    }];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    confirmButton.titleLabel.font = MY_Font(16);
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 2;
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(self).with.offset(-20);
        make.top.mas_equalTo(space5.mas_bottom).with.offset(30);
        make.height.mas_equalTo(@44);
    }];
    
    [self layoutIfNeeded];
    self.height = confirmButton.bottom + 30;
}

- (void)selectValidity {
    MY_DatePickerView *datePickerView = [[MY_DatePickerView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_ScreenHeight)];
    datePickerView.selectDateBlock = ^(NSString *date) {
        self.validityLabel.text = date;
    };
    [[self findController].view addSubview:datePickerView];
}

- (void)selectPosition {
    NSArray *positions = [NSArray arrayWithObjects:@"电风扇",@"师傅说的",@"收费是多少",@"电风扇",@"师傅说的",@"收费是多少", nil];
    MY_PickerView *pickerView = [[MY_PickerView alloc] initWithDataSource:positions title:@"请选择职称"];
    pickerView.confirmBlock = ^(NSString *value) {
        self.positionLabel.text = value;
    };
    [[self findController].view addSubview:pickerView];
}

- (void)passportTypeButtonAction:(UIButton*)button {
    button.selected = !button.selected;
    for (UIButton *btn in self.passportButtonArray) {
        if (btn.tag != button.tag) {
            btn.selected = NO;
        }
    }
    if (button.selected) {
        self.passportType = button.titleLabel.text;
    } else {
        self.passportType = @"";
    }
}

- (void)confirmButtonAction {
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:[MY_Util getUid] forKey:@"uid"];
    if (self.nameTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入您的姓名" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.nameTextField.text forKey:@"name"];
    if (self.phoneTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入您的手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.phoneTextField.text forKey:@"phonen"];
    if (self.emailTextField.text.length) {
        [paramter setObject:self.emailTextField.text forKey:@"email"];
    }
    if (self.idTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入您的身份证号" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.idTextField.text forKey:@"personal"];
    if (self.passportType.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择您的护照类型" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.passportType forKey:@"Passport_type"];
    if (self.passportIdTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入您的护照号码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.passportIdTextField.text forKey:@"passport"];
    if (self.validityLabel.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择您的护照有效期" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.validityLabel.text forKey:@"valid"];
    if (self.roomTypeTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入您的科室名称" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.roomTypeTextField.text forKey:@"secter"];
    if (self.positionLabel.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入您的职称" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.roomTypeTextField.text forKey:@"title"];
    if (self.companyTextField.text.length) {
        [paramter setObject:self.companyTextField.text forKey:@"hospital"];
    }
    if (self.intentionTextView.text.length) {
        [paramter setObject:self.intentionTextView.text forKey:@"request"];
    }
    if (self.submitBlock) {
        self.submitBlock(paramter);
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 3;    //行间距
    paragraphStyle.firstLineHeadIndent = 70;    /**首行缩进宽度*/
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13], NSParagraphStyleAttributeName:paragraphStyle};
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}

- (UILabel*)createLabelWithText:(NSString*)text {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = MY_Font(15);
    label.textColor = [MY_Util setColorWithInt:0x666666];
    return label;
}

- (UITextField*)createTextFieldWithPlaceholder:(NSString*)placeholder {
    UITextField *textField = [[UITextField alloc] init];
    textField.placeholder = placeholder;
    textField.font = MY_Font(12);
    return textField;
}

@end
