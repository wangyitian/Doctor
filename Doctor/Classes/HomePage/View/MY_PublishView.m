//
//  MY_PublishView.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/19.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PublishView.h"
#import "MY_PickerView.h"
@interface MY_PublishView ()

@end

@implementation MY_PublishView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, MY_ScreenWidth-15*2, 250)];
    lineView.layer.borderColor = [MY_Util setColorWithInt:0xcecece].CGColor;
    lineView.layer.borderWidth = 1;
    [self addSubview:lineView];
    
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(6, 10, lineView.width-6*2, lineView.height-10*2)];
    self.contentTextView.font = MY_Font(15);
    [lineView addSubview:self.contentTextView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.bottom+19, MY_ScreenWidth, 1)];
    line.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:line];
    
    UIView *space = [[UIView alloc] initWithFrame:CGRectMake(0, line.bottom, MY_ScreenWidth, 10)];
    space.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:space];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, space.bottom+20, MY_ScreenWidth-20*2, 15)];
    label.text = @"选择您所参加的培训项目";
    label.font = MY_Font(14);
    label.textColor = [MY_Util setColorWithInt:0x666666];
    [self addSubview:label];
    
    UIView *projectView = [[UIView alloc] initWithFrame:CGRectMake(15, label.bottom+15, MY_ScreenWidth-15*2, 45)];
    projectView.layer.borderColor = [MY_Util setColorWithInt:0xcecece].CGColor;
    projectView.layer.borderWidth = 1;
    [self addSubview:projectView];
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(projectView.width-6-15, 0, 6, 12)];
    arrow.centerY = projectView.height/2;
    arrow.image = [UIImage imageNamed:@"arrow"];
    [projectView addSubview:arrow];
    
    self.projectLabel = [[UILabel alloc] initWithFrame:CGRectMake(6+15, 0, projectView.width-(6+15)*2, projectView.height)];
    self.projectLabel.textAlignment = NSTextAlignmentCenter;
    self.projectLabel.text = @"---请选择---";
    self.projectLabel.textColor = [MY_Util setColorWithInt:0xbbbbbb];
    self.projectLabel.font = MY_Font(13);
    [projectView addSubview:self.projectLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectProject)];
    [projectView addGestureRecognizer:tap];
}

- (void)setExperienceArray:(NSArray *)experienceArray {
    _experienceArray = experienceArray;
}

- (void)selectProject {
    if (self.experienceArray.count) {
        MY_PickerView *pickerView = [[MY_PickerView alloc] initWithDataSource:self.experienceArray title:@"选择您所参加的培训项目"];
        pickerView.confirmBlock = ^(NSString *value) {
            self.projectLabel.text = value;
        };
        [[self findController].view addSubview:pickerView];
    } else {
        [((MY_BaseController*)[self findController]) presentAlertWithMessage:@"您还没有参加过培训项目" ConfirmAction:nil completion:nil];
    }
}
@end
