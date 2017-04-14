//
//  MY_PatientListController.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/13.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PatientListController.h"

@interface MY_PatientListController ()

@end

@implementation MY_PatientListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
}

- (void)setupUI {
    [self setTitle:@"患者推荐" isBackButton:YES rightBttonName:nil rightImageName:nil];
}

@end
