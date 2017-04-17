//
//  MY_PublishController.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PublishController.h"

@interface MY_PublishController ()

@end

@implementation MY_PublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupUI];
}

- (void)setupUI {
    [self setTitle:@"发布心得" isBackButton:YES rightBttonName:@"发布" rightImageName:nil];
}

@end
