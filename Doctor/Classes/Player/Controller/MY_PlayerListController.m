//
//  MY_PlayerListController.m
//  Doctor
//
//  Created by 王翼天 on 2017/6/21.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PlayerListController.h"

@interface MY_PlayerListController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *liveTableView;
@property (nonatomic, strong) UITableView *videoTableView;
@property (nonatomic, weak) UIButton *liveButton;
@property (nonatomic, weak) UIButton *videoButton;

@end

@implementation MY_PlayerListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self liveButtonAction];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x/scrollView.width == 0) {
        self.liveButton.selected = YES;
        self.videoButton.selected = NO;
    } else {
        self.liveButton.selected = NO;
        self.videoButton.selected = YES;
    }
}

- (void)liveButtonAction {
    if (!self.liveButton.selected) {
        self.liveButton.selected = YES;
        self.videoButton.selected = NO;
        [self.scrollView scrollRectToVisible:CGRectMake(0, 0, self.scrollView.width, self.scrollView.height) animated:YES];
    }
}

- (void)videoButtonAction {
    if (!self.videoButton.selected) {
        self.videoButton.selected = YES;
        self.liveButton.selected = NO;
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) animated:YES];
    }
}

- (void)setupUI {
    [self setTitle:@"" isBackButton:NO rightBttonName:nil rightImageName:nil];
    
    UIButton *liveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    liveButton.frame = CGRectMake((MY_ScreenWidth-140)/2, 30, 60, 25);
    [liveButton setTitle:@"直播" forState:UIControlStateNormal];
    [liveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [liveButton setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    [liveButton addTarget:self action:@selector(liveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:liveButton];
    self.liveButton = liveButton;
    
    UIButton *videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    videoButton.frame = CGRectMake(liveButton.right+20, 30, 60, 25);
    [videoButton setTitle:@"视频" forState:UIControlStateNormal];
    [videoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [videoButton setTitleColor:[UIColor purpleColor] forState:UIControlStateSelected];
    [videoButton addTarget:self action:@selector(videoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navBar addSubview:videoButton];
    self.videoButton = videoButton;
    
    self.scrollView.frame = CGRectMake(0, 64, MY_ScreenWidth, MY_ScreenHeight-64-49);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.liveTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, self.scrollView.height) style:UITableViewStylePlain];
    self.liveTableView.backgroundColor = MY_RandomColor;
//    self.liveTableView.delegate = self;
//    self.liveTableView.dataSource = self;
    [self.scrollView addSubview:self.liveTableView];
    
    self.videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(MY_ScreenWidth, 0, MY_ScreenWidth, self.scrollView.height) style:UITableViewStylePlain];
    self.videoTableView.backgroundColor = MY_RandomColor;
//    self.videoTableView.delegate = self;
//    self.videoTableView.dataSource = self;
    [self.scrollView addSubview:self.videoTableView];
    self.scrollView.contentSize = CGSizeMake(2*MY_ScreenWidth, self.scrollView.height);
}


@end
