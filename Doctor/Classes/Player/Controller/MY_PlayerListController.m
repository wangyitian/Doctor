//
//  MY_PlayerListController.m
//  Doctor
//
//  Created by 王翼天 on 2017/6/21.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PlayerListController.h"
#import "MY_PushController.h"
#import "MY_PullController.h"
#import "MY_LiveCell.h"
#import "MY_LiveModel.h"
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
    if (scrollView == self.scrollView) {
        if (scrollView.contentOffset.x/scrollView.width == 0) {
            self.liveButton.selected = YES;
            self.videoButton.selected = NO;
        } else if (scrollView.contentOffset.x/scrollView.width == 1) {
            self.liveButton.selected = NO;
            self.videoButton.selected = YES;
        }
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 5+140*(MY_ScreenWidth-10)/(375-10)+5+15+5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellName = @"liveCell";
    MY_LiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (cell == nil) {
        cell = [[MY_LiveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    MY_LiveModel *model = [[MY_LiveModel alloc] init];
    if (tableView == self.liveTableView) {
        model.photo = @"liveDemo";
        model.title = @"直播test直播test直播test直播test直播test";
        model.url = @"rtmp://vc7bd03eb.live.126.net/live/1c1c6329e9ab4ab6837348c23342e775";
    } else {
        model.title = @"点播test点播test点播test点播test点播test";
        model.url = @"http://flv2.bn.netease.com/videolib3/1604/28/fVobI0704/SD/fVobI0704-mobile.mp4";
        model.photo = @"playDemo";
    }
    
    [cell setObject:model indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MY_LiveModel *model = [[MY_LiveModel alloc] init];
    if (tableView == self.liveTableView) {
        model.photo = @"liveDemo";
        model.title = @"直播test直播test直播test直播test直播test";
        model.url = @"rtmp://vc7bd03eb.live.126.net/live/1c1c6329e9ab4ab6837348c23342e775";
        MY_PullController *pull = [[MY_PullController alloc] init];
        pull.isLive = YES;
        pull.model = model;
        [self.navigationController pushViewController:pull animated:YES];
    } else {
        model.photo = @"playDemo";
        model.title = @"点播test点播test点播test点播test点播test";
        model.url = @"http://flv2.bn.netease.com/videolib3/1604/28/fVobI0704/SD/fVobI0704-mobile.mp4";
        MY_PullController *pull = [[MY_PullController alloc] init];
        pull.isLive = NO;
        pull.model = model;
        [self.navigationController pushViewController:pull animated:YES];
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
    self.liveTableView.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    self.liveTableView.delegate = self;
    self.liveTableView.dataSource = self;
    self.liveTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:self.liveTableView];
    
    self.videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(MY_ScreenWidth, 0, MY_ScreenWidth, self.scrollView.height) style:UITableViewStylePlain];
    self.videoTableView.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    self.videoTableView.delegate = self;
    self.videoTableView.dataSource = self;
    self.videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.scrollView addSubview:self.videoTableView];
    self.scrollView.contentSize = CGSizeMake(2*MY_ScreenWidth, self.scrollView.height);
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"live"] forState:UIControlStateNormal];
    btn.frame = CGRectMake((MY_ScreenWidth-60)/2, MY_ScreenHeight-70-64-49, 60, 60);
    btn.alpha = 0.5;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:btn];
    
}

- (void)btnAction {
    MY_PushController *vc = [[MY_PushController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
