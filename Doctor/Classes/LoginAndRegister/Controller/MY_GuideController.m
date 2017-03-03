//
//  MY_GuideController.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/3.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_GuideController.h"
#import "MY_TabController.h"
@interface MY_GuideController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation MY_GuideController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    NSArray *imageArray = [NSArray arrayWithObjects:@"icon",@"tab_college_s",@"tab_college",@"tab_homePage_s",@"tab_homePage", nil];
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageArray[i]];
        imageView.frame = CGRectMake(MY_ScreenWidth*i, 0, MY_ScreenWidth, MY_ScreenHeight);
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(MY_ScreenWidth*imageArray.count, MY_ScreenHeight);
    UIButton * button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor=[UIColor clearColor];
    button.frame=CGRectMake(MY_ScreenWidth * (imageArray.count-1), 0, MY_ScreenWidth, MY_ScreenHeight);
    [button addTarget:self action:@selector(entermainVC) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:button];
}

- (void)entermainVC
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 当前版本号 == 上次使用的版本：显示TabBarViewController
    [UIApplication sharedApplication].statusBarHidden = NO;
    window.rootViewController = [[MY_TabController alloc] init];
    
    // 如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = @"CFBundleShortVersionString";
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
}

@end
