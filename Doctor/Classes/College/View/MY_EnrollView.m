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
#define TAG_FOR_BUTTON  2000
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
    UIView *space1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 5)];
    space1.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:space1];
    
    UILabel *nameLabel = [self createLabelWithText:@"您的姓名"];
    nameLabel.frame = CGRectMake(20, space1.bottom+15, 70, 15);
    [self addSubview:nameLabel];
    
    self.nameTextField = [self createTextFieldWithPlaceholder:@"请输入您的姓名"];
    self.nameTextField.frame = CGRectMake(nameLabel.right, nameLabel.top, MY_ScreenWidth-nameLabel.right, nameLabel.height);
    [self addSubview:self.nameTextField];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(6, nameLabel.bottom+15, MY_ScreenWidth-6*2, 0.5)];
    line1.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:line1];
    
    UILabel *phoneLabel = [self createLabelWithText:@"您的电话"];
    phoneLabel.frame = CGRectMake(nameLabel.left, line1.top+15, nameLabel.width, nameLabel.height);
    [self addSubview:phoneLabel];
    
    self.phoneTextField = [self createTextFieldWithPlaceholder:@"请输入您的手机号"];
    self.phoneTextField.frame = CGRectMake(self.nameTextField.left, phoneLabel.top, self.nameTextField.width, phoneLabel.height);
    [self addSubview:self.phoneTextField];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(line1.left, phoneLabel.bottom+15, line1.width, line1.height)];
    line2.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:line2];
    
    UILabel *emailLabel = [self createLabelWithText:@"您的邮箱"];
    emailLabel.frame = CGRectMake(phoneLabel.left, line2.top+15, phoneLabel.width, phoneLabel.height);
    [self addSubview:emailLabel];
    
    self.emailTextField = [self createTextFieldWithPlaceholder:@"输入您的邮箱"];
    self.emailTextField.frame = CGRectMake(self.phoneTextField.left, emailLabel.top, self.phoneTextField.width, self.phoneTextField.height);
    [self addSubview:self.emailTextField];
    
    UIView *space2 = [[UIView alloc] initWithFrame:CGRectMake(0, emailLabel.bottom+15, MY_ScreenWidth, 10)];
    space2.backgroundColor = space1.backgroundColor;
    [self addSubview:space2];
    
    UILabel *idLabel = [self createLabelWithText:@"身份证号"];
    idLabel.frame = CGRectMake(emailLabel.left, space2.bottom+15, emailLabel.width, emailLabel.height);
    [self addSubview:idLabel];
    
    self.idTextField = [self createTextFieldWithPlaceholder:@"请输入您的身份证号码"];
    self.idTextField.frame = CGRectMake(self.emailTextField.left, idLabel.top, self.emailTextField.width, self.emailTextField.height);
    [self addSubview:self.idTextField];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(line2.left, idLabel.bottom+15, line2.width, line2.height)];
    line3.backgroundColor = line2.backgroundColor;
    [self addSubview:line3];
    
    UILabel *passportTypeLabel = [self createLabelWithText:@"护照类型"];
    passportTypeLabel.frame = CGRectMake(idLabel.left, line3.top+15, idLabel.width, idLabel.height);
    [self addSubview:passportTypeLabel];
    
    NSArray *buttonTitles = [NSArray arrayWithObjects:@" 因私",@" 因公", nil];
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(13);
        button.tag = TAG_FOR_BUTTON + i;
        button.frame = CGRectMake(100+100*i, line3.top+5, 80, 35);
        [button setImage:[UIImage imageNamed:@"option"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"option_s"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(passportTypeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.passportButtonArray addObject:button];
    }
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(line3.left, passportTypeLabel.bottom+15, line3.width, line3.height)];
    line4.backgroundColor = line3.backgroundColor;
    [self addSubview:line4];
    
    UILabel *passportIdLabel = [self createLabelWithText:@"护照号码"];
    passportIdLabel.frame = CGRectMake(passportTypeLabel.left, line4.top+15, passportTypeLabel.width, passportTypeLabel.height);
    [self addSubview:passportIdLabel];
    
    self.passportIdTextField = [self createTextFieldWithPlaceholder:@"请输入您的护照号码"];
    self.passportIdTextField.frame = CGRectMake(self.idTextField.left, line4.top+15, self.idTextField.width, self.idTextField.height);
    [self addSubview:self.passportIdTextField];
    
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(line4.left, passportIdLabel.bottom+15, line4.width, line4.height)];
    line5.backgroundColor = line4.backgroundColor;
    [self addSubview:line5];
    
    UIView *validityView = [[UIView alloc] initWithFrame:CGRectMake(0, line5.top, MY_ScreenWidth, 45)];
    UITapGestureRecognizer *validityTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectValidity)];
    [validityView addGestureRecognizer:validityTap];
    [self addSubview:validityView];
    
    UILabel *titleLabel = [self createLabelWithText:@"请选择护照有效期"];
    titleLabel.frame = CGRectMake(20, 15, 130, 15);
    [validityView addSubview:titleLabel];
    
    self.validityLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right+10, 0, 100, 13)];
    self.validityLabel.centerY = titleLabel.centerY;
    self.validityLabel.textColor = [MY_Util setColorWithInt:0xbbbbbb];
    self.validityLabel.font = MY_Font(12);
    [validityView addSubview:self.validityLabel];
    
    UIImageView *arrow1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    arrow1.frame = CGRectMake(MY_ScreenWidth-20-7, 0, 7, 7);
    arrow1.centerY = titleLabel.centerY;
    [validityView addSubview:arrow1];
    
    UIView *space3 = [[UIView alloc] initWithFrame:CGRectMake(0, validityView.bottom, MY_ScreenWidth, space2.height)];
    space3.backgroundColor = space2.backgroundColor;
    [self addSubview:space3];
    
    UILabel *roomTypeLabel = [self createLabelWithText:@"科  室"];
    roomTypeLabel.frame = CGRectMake(passportIdLabel.left, space3.bottom+15, passportIdLabel.width, passportIdLabel.height);
    [self addSubview:roomTypeLabel];
    
    self.roomTypeTextField = [self createTextFieldWithPlaceholder:@"请输入科室名称"];
    self.roomTypeTextField.frame = CGRectMake(self.passportIdTextField.left, roomTypeLabel.top, self.passportIdTextField.width, self.passportIdTextField.height);
    [self addSubview:self.roomTypeTextField];
    
    UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(line5.left, roomTypeLabel.bottom+15, line5.width, line5.height)];
    line6.backgroundColor = line5.backgroundColor;
    [self addSubview:line6];
    
    UIView *positionView = [[UIView alloc] initWithFrame:CGRectMake(0, line6.top, MY_ScreenWidth, 45)];
    UITapGestureRecognizer *positionTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPosition)];
    [positionView addGestureRecognizer:positionTap];
    [self addSubview:positionView];
    
    UILabel *pLabel = [self createLabelWithText:@"请选择职称"];
    pLabel.frame = CGRectMake(roomTypeLabel.left, 15, 85, 15);
    [positionView addSubview:pLabel];
    
    self.positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(pLabel.right+10, 0, 120, 13)];
    self.positionLabel.centerY = pLabel.centerY;
    self.positionLabel.font = MY_Font(12);
    self.positionLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [positionView addSubview:self.positionLabel];
    
    UIImageView *arrow2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    arrow2.frame = CGRectMake(MY_ScreenWidth-20-7, 0, 7, 7);
    arrow2.centerY = pLabel.centerY;
    [positionView addSubview:arrow2];
    
    UIView *line7 = [[UIView alloc] initWithFrame:CGRectMake(line6.left, positionView.bottom, line6.width, line6.height)];
    line7.backgroundColor = line6.backgroundColor;
    [self addSubview:line7];
    
    UILabel *companyLabel = [self createLabelWithText:@"工作单位"];
    companyLabel.frame = CGRectMake(roomTypeLabel.left, line7.top+15, roomTypeLabel.width, roomTypeLabel.height);
    [self addSubview:companyLabel];
    
    self.companyTextField = [self createTextFieldWithPlaceholder:@"请输入您的单位名称"];
    self.companyTextField.frame = CGRectMake(self.roomTypeTextField.left, 0, self.roomTypeTextField.width, self.roomTypeTextField.height);
    self.companyTextField.centerY = companyLabel.centerY;
    [self addSubview:self.companyTextField];
    
    UIView *space4 = [[UIView alloc] initWithFrame:CGRectMake(0, companyLabel.bottom+15, space3.width, space3.height)];
    space4.backgroundColor = space3.backgroundColor;
    [self addSubview:space4];
    
    self.intentionTextView = [[MY_TextView alloc] initWithFrame:CGRectMake(15, space4.bottom, MY_ScreenWidth-15*2, 90)];
    self.intentionTextView.font = MY_Font(12);
    self.intentionTextView.delegate = self;
    self.intentionTextView.myPlaceholderColor = [MY_Util setColorWithInt:0xcccccc];
    self.intentionTextView.myPlaceholder = @"                     请输入您想出行的地区，医院，时间等";
    [self addSubview:self.intentionTextView];
    
    UILabel *intentionLabel = [self createLabelWithText:@"进修意向"];
    intentionLabel.frame = CGRectMake(5, 8, 64, 15);
    [self.intentionTextView addSubview:intentionLabel];
    
    UIView *space5 = [[UIView alloc] initWithFrame:CGRectMake(space4.left, self.intentionTextView.bottom, space4.width, space4.height)];
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
    confirmButton.frame = CGRectMake(20, space5.bottom+30, MY_ScreenWidth-20*2, 44);
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    
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
    NSString *intention = [self.intentionTextView.text substringFromIndex:21];
    if (intention.length) {
        [paramter setObject:intention forKey:@"request"];
    }
    if (self.submitBlock) {
        self.submitBlock(paramter);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"                     ";
}

-(void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length < 21) {
        textView.text = @"                     ";
    }
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
