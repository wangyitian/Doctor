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

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addHeaderRefresh:YES footerRefresh:YES];
    [self loadMore:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 网络请求
- (void)loadMore:(BOOL)loadMore {
    MY_MessageModel *model = [[MY_MessageModel alloc] init];
    model.time = @"2017-01-01";
    model.message = @"别靠近阿富汗客户的反馈就啊好多款精华反馈就啊是大喊大叫开始恢复叫卡收到后即可shark啊收到后即可哈速度加快";
    
    MY_MessageModel *model1 = [[MY_MessageModel alloc] init];
    model1.time = @"2017-01-01";
    model1.message = @"别喊大叫开始恢复叫卡收到后即可shark啊收到后即可哈速度加快";
    
    MY_MessageModel *model2 = [[MY_MessageModel alloc] init];
    model2.time = @"2017-01-01";
    model2.message = @"iiiiiiiiiiiiiiiiiiiiiiiiiii客户的反馈就啊好多款精华反馈就啊是大喊大叫开始恢复叫卡收到后即可shark啊收到后即可iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:model];
    [array addObject:model1];
    [array addObject:model2];
    [self.dataSource addObject:array];
//    [self.tableView reloadData];
}

#pragma mark - 下拉刷新上拉加载更多触发方法
- (void)headerRereshing {
    [self loadMore:NO];
}

- (void)footerRereshing {
    [self loadMore:YES];
}

#pragma mark -
- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_MessageCell class];
}

#pragma mark - UI
- (void)setupUI {
    [self setTitle:@"消息" isBackButton:NO rightBttonName:nil rightImageName:nil];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 0, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
}
@end
