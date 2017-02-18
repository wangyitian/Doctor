//
//  MY_BaseScrollController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseScrollController.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface MY_BaseScrollController () <UIScrollViewDelegate>
@property (nonatomic, strong) TPKeyboardAvoidingScrollView* scrollView;
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
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
