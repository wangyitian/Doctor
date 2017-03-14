//
//  MY_BaseScrollController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseScrollController.h"
@interface MY_BaseScrollController () <UIScrollViewDelegate>
@end

@implementation MY_BaseScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initScrollView];
}

- (void)initScrollView {
    self.scrollView = [[TPKeyboardAvoidingScrollView alloc] initWithFrame:self.view.bounds];
    [self.scrollView contentSizeToFit];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
}

@end
