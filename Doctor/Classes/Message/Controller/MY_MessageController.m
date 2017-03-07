//
//  MY_MessageController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MessageController.h"
#import "MY_LoginController.h"
#import "MY_MessageCell.h"
#import "MY_MessageModel.h"
@interface MY_MessageController ()

@end

@implementation MY_MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addHeaderRefresh:YES footerRefresh:YES];
    [self loadMore:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)loadMore:(BOOL)loadMore {
    MY_MessageModel *model = [[MY_MessageModel alloc] init];
    model.time = @"2017-01-01";
    model.message = @"别靠近阿富汗客户的反馈就啊好多款精华反馈就啊是大喊大叫开始恢复叫卡收到后即可shark啊收到后即可哈速度加快";
    
    MY_MessageModel *model1 = [[MY_MessageModel alloc] init];
    model1.time = @"2017-01-01";
    model1.message = @"别喊大叫开始恢复叫卡收到后即可shark啊收到后即可哈速度加快";
    
    MY_MessageModel *model2 = [[MY_MessageModel alloc] init];
    model2.time = @"2017-01-01";
    model2.message = @"别靠近阿富汗客户的反馈就啊好多款精华反阿斯顿看健康就拉开多久俩家啦看电视剧福利卡三等奖卢卡斯简单浪费空间啊舍得离开就发了开始的家里看世界卢卡斯家里大声讲鲁昆吉里卡三等奖快乐馈就啊是大喊大叫开始恢复叫卡收到后即可shark啊收到后即可哈速度加快别靠近阿富汗客户的反馈就啊好多款精华反阿斯顿看健康就拉开多久俩家啦看电视剧福利卡三等奖卢卡斯简单浪费空间啊舍得离开就发了开始的开始的家里看世界卢卡斯家里大声讲鲁昆吉里卡三等奖快乐馈就啊是大喊大叫开始恢复叫卡收收收到后即可shark啊收到后即可哈速度加快";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:model];
    [array addObject:model1];
    [array addObject:model2];
    [self.dataSource addObject:array];
}

- (void)headerRereshing {
    [self loadMore:NO];
}

- (void)footerRereshing {
    [self loadMore:YES];
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_MessageCell class];
}

- (void)setupUI {
    [self setTitle:@"消息" isBackButton:NO rightBttonName:nil rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
}
@end
