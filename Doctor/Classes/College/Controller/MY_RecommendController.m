//
//  MY_RecommendController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RecommendController.h"
#import "MY_RecommendView.h"
@interface MY_RecommendController ()

@end

@implementation MY_RecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"患者推荐" isBackButton:YES rightBttonName:nil rightImageName:nil];
    [self setupUI];
}

- (void)setupUI {
    MY_RecommendView *recommendView = [[MY_RecommendView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    [self.scrollView addSubview:recommendView];
    
}
@end
