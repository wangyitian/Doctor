//
//  MY_RecommendView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RecommendView.h"
#import "MY_PickerView.h"
#import "MY_BaseWebController.h"
#define TAG_FOR_PATIENT 2000    
#define TAG_FOR_AGREE   3000
@interface MY_RecommendView ()<UITextViewDelegate>
@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *sickTypeTextField;
@property (nonatomic, strong) NSMutableArray *patientButtons;
@property (nonatomic, strong) UILabel *sickTypeLabel;
@property (nonatomic, strong) MY_TextView *sickTextView;
@property (nonatomic, strong) NSMutableArray *agreeButtons;
@property (nonatomic, copy) NSString *isPatient;
@property (nonatomic, strong) UIButton *isAgreeButton;
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
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 70, 15)];
    nameLabel.textColor = [MY_Util setColorWithInt:0x666666];
    nameLabel.font = MY_Font(15);
    nameLabel.text = @"患者姓名";
    [self addSubview:nameLabel];
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameLabel.right, nameLabel.top, MY_ScreenWidth-nameLabel.right-10, nameLabel.height)];
    self.nameTextField.font = MY_Font(12);
    self.nameTextField.placeholder = @"请输入患者的姓名";
    [self addSubview:self.nameTextField];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(6, nameLabel.bottom+15, MY_ScreenWidth-6*2, 0.5)];
    line1.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:line1];
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.left, line1.top+15, nameLabel.width, nameLabel.height)];
    phoneLabel.textColor = [MY_Util setColorWithInt:0x666666];
    phoneLabel.font = MY_Font(15);
    phoneLabel.text = @"联系电话";
    [self addSubview:phoneLabel];
    
    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.nameTextField.left, phoneLabel.top, self.nameTextField.width, self.nameTextField.height)];
    self.phoneTextField.font = MY_Font(12);
    self.phoneTextField.placeholder = @"请输入患者或家属手机号";
    [self addSubview:self.phoneTextField];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(line1.left, phoneLabel.bottom+15, line1.width, line1.height)];
    line2.backgroundColor = line1.backgroundColor;
    [self addSubview:line2];
    
    NSArray *buttonTitles = [NSArray arrayWithObjects:@" 患者本人",@" 患者家属", nil];
    for (int i = 0; i < buttonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"option"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"option_s"] forState:UIControlStateSelected];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(14);
        button.tag = TAG_FOR_PATIENT + i;
        [button addTarget:self action:@selector(patientButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake((MY_ScreenWidth-100*2)/2+100*i, line2.top+5, 100, 35);
        [self addSubview:button];
        [self.patientButtons addObject:button];
    }
    
    UIView *space1 = [[UIView alloc] initWithFrame:CGRectMake(0, line2.top+45, MY_ScreenWidth, 10)];
    space1.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:space1];
    
    UILabel *sickTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabel.left, space1.bottom+15, phoneLabel.width, phoneLabel.height)];
    sickTypeLabel.textColor = [MY_Util setColorWithInt:0x666666];
    sickTypeLabel.font = MY_Font(15);
    sickTypeLabel.text = @"患者病种";
    [self addSubview:sickTypeLabel];
    
    self.sickTypeTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.nameTextField.left, sickTypeLabel.top, self.nameTextField.width, self.nameTextField.height)];
    self.sickTypeTextField.font = MY_Font(12);
    self.sickTypeTextField.placeholder = @"请输入患者病种";
    [self addSubview:self.sickTypeTextField];
    
    UIView *space2 = [[UIView alloc] initWithFrame:CGRectMake(space1.left, space1.bottom+45, space1.width, space1.height)];
    space2.backgroundColor = space1.backgroundColor;
    [self addSubview:space2];
    
    self.sickTextView = [[MY_TextView alloc] initWithFrame:CGRectMake(15, space2.bottom, MY_ScreenWidth-15*2, 90)];
    self.sickTextView.font = MY_Font(12);
    self.sickTextView.delegate = self;
    self.sickTextView.myPlaceholderColor = [MY_Util setColorWithInt:0xcccccc];
    self.sickTextView.myPlaceholder = @"                     请描述患者病情";
    [self addSubview:self.sickTextView];
    
    UILabel *intentionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, 64, 15)];
    intentionLabel.textColor = [MY_Util setColorWithInt:0x666666];
    intentionLabel.font = MY_Font(15);
    intentionLabel.text = @"病        情";
    [self.sickTextView addSubview:intentionLabel];
    
    UIView *space3 = [[UIView alloc] initWithFrame:CGRectMake(space2.left, self.sickTextView.bottom, space2.width, space2.height)];
    space3.backgroundColor = space2.backgroundColor;
    [self addSubview:space3];
    
    
    self.isAgreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.isAgreeButton.frame = CGRectMake((MY_ScreenWidth-300-20)/2, space3.bottom+15, 20, 20);
    [self.isAgreeButton setImage:[UIImage imageNamed:@"option"] forState:UIControlStateNormal];
    [self.isAgreeButton setImage:[UIImage imageNamed:@"option_s"] forState:UIControlStateSelected];
    [self.isAgreeButton addTarget:self action:@selector(isAgreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.isAgreeButton];
    
    UIButton *protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    protocolButton.frame = CGRectMake(self.isAgreeButton.right, self.isAgreeButton.top, 300, 20);
    [protocolButton setTitle:@"已阅读并同意《麻省医疗国际患者推荐服务协议》" forState:UIControlStateNormal];
    [protocolButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    protocolButton.titleLabel.font = MY_Font(13);
    [protocolButton addTarget:self action:@selector(protocolButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:protocolButton];
    
    UIButton *confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmButton.titleLabel.font = MY_Font(15);
    confirmButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    confirmButton.layer.masksToBounds = YES;
    confirmButton.layer.cornerRadius = 2;
    confirmButton.frame = CGRectMake(20, protocolButton.bottom+30+15, MY_ScreenWidth-20*2, 44);
    [confirmButton addTarget:self action:@selector(confirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
  
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
- (void)isAgreeButtonAction:(UIButton*)button {
    button.selected = !button.selected;
    self.isAgreeButton.selected = button.selected;
}

- (void)protocolButtonAction {
    MY_BaseWebController *webVC = [[MY_BaseWebController alloc] init];
    webVC.url = @"https://baidu.com";
//    webVC.navTitle = @"麻省医疗国际患者推荐服务协议";
    [[self findController].navigationController pushViewController:webVC animated:YES];
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
        if (button.tag-TAG_FOR_PATIENT == 0) {
            self.isPatient = @"1";
        } else {
            self.isPatient = @"0";
        }
    } else {
        self.isPatient = @"";
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
    [paramter setObject:self.phoneTextField.text forKey:@"iphon"];
    if (self.sickTypeTextField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请选择患者病种" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
        [[self findController] presentViewController:alert animated:YES completion:nil];
        return;
    }
    [paramter setObject:self.sickTypeTextField.text forKey:@"disease"];
    if (self.isPatient.length) {
        [paramter setObject:self.isPatient forKey:@"relation"];
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
