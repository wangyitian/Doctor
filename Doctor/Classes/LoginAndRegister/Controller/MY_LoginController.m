//
//  MY_LoginController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/16.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_LoginController.h"
#import "MY_ScanQRCodeController.h"
@interface MY_LoginController ()

@end

@implementation MY_LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"登陆" isBackButton:YES rightBttonName:nil rightImageName:nil];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    MY_ScanQRCodeController *vc = [[MY_ScanQRCodeController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
