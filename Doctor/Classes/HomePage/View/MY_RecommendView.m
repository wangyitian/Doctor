//
//  MY_RecommendView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RecommendView.h"
#import "MY_PickerView.h"
@interface MY_RecommendView ()<UITextViewDelegate>
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) NSMutableArray *patientButtons;
@property (nonatomic, strong) UILabel *sickTypeLabel;
@property (nonatomic, strong) MY_TextView *sickTextView;
@property (nonatomic, strong) NSMutableArray *agreeButtons;
@property (nonatomic, copy) NSString *isPatient;
@property (nonatomic, copy) NSString *isAgree;
@end
@implementation MY_RecommendView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.patientButtons = [NSMutableArray array];
        self.agreeButtons = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = [MY_Util setColorWithInt:0x666666];
    nameLabel.font = MY_Font(15);
    nameLabel.text = @"患者姓名";
    [self addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@15);
        make.left.mas_equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(70, 15));
    }];
    
    self.nameTextField = [[UITextField alloc] init];
    self.nameTextField.font = MY_Font(12);
    self.nameTextField.placeholder = @"请输入患者的姓名";
    [self addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right);
        make.top.mas_equalTo(nameLabel);
        make.height.mas_equalTo(nameLabel);
        make.right.mas_equalTo(self).with.offset(-10);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@6);
        make.top.mas_equalTo(nameLabel.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth-6*2, 0.5));
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textColor = [MY_Util setColorWithInt:0x666666];
    phoneLabel.font = MY_Font(15);
    phoneLabel.text = @"联系电话";
    [self addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel);
        make.top.mas_equalTo(line1).with.offset(15);
        make.size.mas_equalTo(nameLabel);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.font = MY_Font(12);
    self.phoneTextField.placeholder = @"请输入患者或家属手机号";
    [self addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameTextField);
        make.top.mas_equalTo(phoneLabel);
        make.size.mas_equalTo(self.nameTextField);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = line1.backgroundColor;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(line1);
        make.size.mas_equalTo(line1);
        make.top.mas_equalTo(phoneLabel.mas_bottom).with.offset(15);
    }];
    
    NSArray *buttonTitles = [NSArray arrayWithObjects:@" 患者本人",@" 患者家属", nil];
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"option"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"option_s"] forState:UIControlStateSelected];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(14);
        button.tag = 2000 + i;
        [button addTarget:self action:@selector(patientButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.patientButtons addObject:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset((MY_ScreenWidth-100*2)/2+100*i);
            make.top.mas_equalTo(line2).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(100, 35));
        }];
    }
    
    UIView *space1 = [[UIView alloc] init];
    space1.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:space1];
    [space1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(line2).with.offset(45);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 10));
    }];
    
    UIView *sickTypeView = [[UIView alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectSickType)];
    [sickTypeView addGestureRecognizer:tap];
    [self addSubview:sickTypeView];
    [sickTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(space1.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 45));
    }];
    
    UILabel *sickTypeLabel = [[UILabel alloc] init];
    sickTypeLabel.textColor = [MY_Util setColorWithInt:0x666666];
    sickTypeLabel.font = MY_Font(15);
    sickTypeLabel.text = @"患者病种";
    [sickTypeView addSubview:sickTypeLabel];
    [sickTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(phoneLabel);
        make.top.mas_equalTo(@15);
        make.size.mas_equalTo(phoneLabel);
    }];
    
    self.sickTypeLabel = [[UILabel alloc] init];
    self.sickTypeLabel.textColor = [MY_Util setColorWithInt:0x666666];
    self.sickTypeLabel.font = MY_Font(12);
    self.sickTypeLabel.text = @"请选择患者病种";
    [sickTypeView addSubview:self.sickTypeLabel];
    [self.sickTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(sickTypeLabel.mas_right);
        make.top.mas_equalTo(sickTypeLabel);
        make.height.mas_equalTo(sickTypeLabel);
        make.width.mas_equalTo(150);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [sickTypeView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(7, 7));
        make.right.mas_equalTo(sickTypeView).with.offset(-20);
        make.centerY.mas_equalTo(sickTypeLabel);
    }];
    
    UIView *space2 = [[UIView alloc] init];
    space2.backgroundColor = space1.backgroundColor;
    [self addSubview:space2];
    [space2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space1);
        make.size.mas_equalTo(space1);
        make.top.mas_equalTo(sickTypeView.mas_bottom);
    }];
    
    self.sickTextView = [[MY_TextView alloc] init];
    self.sickTextView.font = MY_Font(12);
    self.sickTextView.delegate = self;
    self.sickTextView.myPlaceholderColor = [MY_Util setColorWithInt:0xcccccc];
    self.sickTextView.myPlaceholder = @"                     请描述患者病情";
    [self addSubview:self.sickTextView];
    [self.sickTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(15);
        make.top.mas_equalTo(space2.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth-30, 90));
    }];
    
    UILabel *intentionLabel = [[UILabel alloc] init];
    intentionLabel.textColor = [MY_Util setColorWithInt:0x666666];
    intentionLabel.font = MY_Font(15);
    intentionLabel.text = @"病        情";
    [self.sickTextView addSubview:intentionLabel];
    [intentionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@5);
        make.top.mas_equalTo(8);
        make.size.mas_equalTo(CGSizeMake(64, 15));
    }];
    
    UIView *space3 = [[UIView alloc] init];
    space3.backgroundColor = space2.backgroundColor;
    [self addSubview:space3];
    [space3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(space2);
        make.size.mas_equalTo(space2);
        make.top.mas_equalTo(self.sickTextView.mas_bottom);
    }];
    
    UILabel *agreeLabel = [[UILabel alloc] init];
    agreeLabel.textColor = [MY_Util setColorWithInt:0x666666];
    agreeLabel.font = MY_Font(15);
    agreeLabel.text = @"是否征得患者同意";
    [self addSubview:agreeLabel];
    [agreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(intentionLabel);
        make.top.mas_equalTo(space3.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(140, 15));
    }];
    
    NSArray *agreeTitles = [NSArray arrayWithObjects:@" 是",@" 否", nil];
    for (int i = 0; i < agreeTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"option"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"option_s"] forState:UIControlStateSelected];
        [button setTitle:agreeTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(14);
        button.tag = 3000 + i;
        [button addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.agreeButtons addObject:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset(180+60*i);
            make.top.mas_equalTo(space3.mas_bottom).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(60, 35));
        }];
    }
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = MY_Font(15);
    confirmButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 2;
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@20);
        make.top.mas_equalTo(agreeLabel.mas_bottom).with.offset(30+15);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth-20*2, 44));
    }];
  
    [self layoutIfNeeded];
    self.height = confirmButton.bottom + 30;
}

- (void)selectSickType {
    NSArray *sickTypes = [NSArray arrayWithObjects:@"电风扇",@"师傅说的",@"收费是多少",@"电风扇",@"师傅说的",@"收费是多少", nil];
    MY_PickerView *pickerView = [[MY_PickerView alloc] initWithDataSource:sickTypes title:@"请选择患者病种"];
    pickerView.confirmBlock = ^(NSString *value) {
        self.sickTypeLabel.text = value;
    };
    [[self findController].view addSubview:pickerView];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"                     ";
}

-(void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length < 21) {
        textView.text = @"                     ";
    }
}

- (void)patientButtonAction:(UIButton*)button {
    button.selected = !button.selected;
    for (UIButton *btn in self.patientButtons) {
        if (btn.tag != button.tag) {
            btn.selected = NO;
        }
    }
    if (button.selected) {
        if (button.tag-2000 == 0) {
            self.isPatient = @"1";
        } else {
            self.isPatient = @"0";
        }
    } else {
        self.isPatient = @"";
    }
}

- (void)agreeButtonAction:(UIButton*)button {
    button.selected = !button.selected;
    for (UIButton *btn in self.agreeButtons) {
        if (btn.tag != button.tag) {
            btn.selected = NO;
        }
    }
    if (button.selected) {
        if (button.tag-3000 == 0) {
            self.isAgree = @"1";
        } else {
            self.isAgree = @"0";
        }
    } else {
        self.isAgree = @"";
    }
}

- (void)confirmButtonAction {
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:[MY_Util getUid] forKey:@"uid"];
    if (self.nameTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入患者姓名" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.nameTextField.text forKey:@"username"];
    if (self.phoneTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入患者或家属手机号" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.phoneTextField.text forKey:@"phonen"];
    if ([self.sickTypeLabel.text isEqualToString:@"请选择患者病种"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择患者病种" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.sickTypeLabel.text forKey:@"disease"];
    if (self.isPatient.length) {
        [paramter setObject:self.isPatient forKey:@"relation"];
    }
    if (self.isAgree.length) {
        [paramter setObject:self.isAgree forKey:@"agree"];
    }
    
    NSString *sick = [self.sickTextView.text substringFromIndex:21];
    if (sick.length) {
        [paramter setObject:sick forKey:@"illness"];
    }
    if (self.recommendBlock) {
        self.recommendBlock(paramter);
    }
}

@end
