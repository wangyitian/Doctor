//
//  MY_CourseWebController.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/25.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseWebController.h"
#import "MY_EnrollController.h"
#import <UShareUI/UShareUI.h>
@interface MY_CourseWebController ()

@end

@implementation MY_CourseWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.height -= 49;
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.backgroundColor = [UIColor whiteColor];
    [phoneButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    [phoneButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    phoneButton.titleLabel.font = MY_Font(15);
    phoneButton.frame = CGRectMake(0, self.view.height-50, MY_ScreenWidth/2, 50);
    [phoneButton addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneButton];
    
    UIButton *enrollButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enrollButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [enrollButton setTitle:@"立即报名" forState:UIControlStateNormal];
    [enrollButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    enrollButton.titleLabel.font = MY_Font(15);
    enrollButton.frame = CGRectMake(MY_ScreenWidth/2, self.view.height-50, MY_ScreenWidth/2, 50);
    [enrollButton addTarget:self action:@selector(enrollButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enrollButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height-50, MY_ScreenWidth, 0.5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xdddddd];
    [self.view addSubview:line];

}

- (void)phoneButtonAction {
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18514616528"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
}

- (void)enrollButtonAction {
    MY_EnrollController *enrollVC = [[MY_EnrollController alloc] init];
    [self.navigationController pushViewController:enrollVC animated:YES];
}





@end
