//
//  MY_HomePageController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_HomePageController.h"

@interface MY_HomePageController ()

@end

@implementation MY_HomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"首页" isBackButton:YES rightBttonName:@"search" rightImageName:nil];
    // Do any additional setup after loading the view.
}

- (void)rightButtonAction {
    UISearchController *vc = [[UISearchController alloc] initWithSearchResultsController:nil];
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
