//
//  MY_RegisterController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RegisterController.h"
#import "MY_RegisterView.h"
@interface MY_RegisterController ()

@end

@implementation MY_RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    MY_RegisterView *registerView = [[MY_RegisterView alloc] initWithFrame:self.view.bounds];
    registerView.validateBlock = ^(NSString *account){
    
    };
    registerView.confirmBlock = ^(NSString *account, NSString *pwd, NSString *validate){
    
    };
    [self.view addSubview:registerView];
}

@end
