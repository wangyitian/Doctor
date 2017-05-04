//
//  MY_MessageController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MessageController.h"
#import "MY_MessageCell.h"
#import "MY_MessageModel.h"
@interface MY_MessageController ()

@end

@implementation MY_MessageController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self addHeaderRefresh:YES footerRefresh:NO];
    [self loadMore:NO];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 网络请求
- (void)loadMore:(BOOL)loadMore {
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:[MY_Util getUid] forKey:@"uid"];
    [model getDataWithURL:MY_API_MESSAGELIST paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        NSMutableArray *messages = [NSMutableArray array];
        for (NSDictionary *messageDic in dic[@"huanzhe"]) {
            MY_MessageModel *model = [[MY_MessageModel alloc] initWithDictionary:messageDic];
            [messages addObject:model];
        }
        for (NSDictionary *messageDic in dic[@"tuijian"]) {
            MY_MessageModel *model = [[MY_MessageModel alloc] initWithDictionary:messageDic];
            [messages addObject:model];
        }
        [self.dataSource removeAllObjects];
        [self.dataSource addObject:messages];
        [self.tableView reloadData];
    }];
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
    self.tableView.contentInset = UIEdgeInsetsMake(MY_APP_STATUS_NAVBAR_HEIGHT, 0, 49, 0);
    self.tableView.backgroundColor = [UIColor whiteColor];
}
@end
