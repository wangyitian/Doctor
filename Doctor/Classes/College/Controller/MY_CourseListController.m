//
//  MY_CourseListController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseListController.h"
#import "MY_CourseCell.h"
#import "MY_CourseModel.h"
@interface MY_CourseListController ()

@end

@implementation MY_CourseListController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHeaderRefresh:YES footerRefresh:NO];
    [self setupUI];
    [self loadMore:NO];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - 网络请求
- (void)loadMore:(BOOL)loadMore {
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:[NSString stringWithFormat:@"%ld",(long)self.index] forKey:@"type"];
    if ([self.listType isEqualToString:@"美国"]) {
        [paramter setObject:@"1" forKey:@"region"];
    } else if ([self.listType isEqualToString:@"台湾"]) {
        [paramter setObject:@"2" forKey:@"region"];
    } else if ([self.listType isEqualToString:@"新加坡"]) {
        [paramter setObject:@"3" forKey:@"region"];
    }
    [model getDataWithURL:MY_API_COURSELIST paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        NSMutableArray *courses = [NSMutableArray array];
        NSArray *responseArray = [dic arrayWithKey:@"kecheng"];
        for (NSDictionary *courseDic in responseArray) {
            MY_CourseModel *model = [[MY_CourseModel alloc] initWithDictionary:courseDic];
            [courses addObject:model];
        }
        [self.dataSource removeAllObjects];
        [self.dataSource addObject:courses];
        [self.tableView reloadData];
    }];
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_CourseCell class];
}

#pragma mark - 上拉加载下拉刷新触发方法
- (void)headerRereshing {
    [self loadMore:NO];
}

#pragma mark - UI
- (void)setupUI {
    self.tableView.height -= (MY_APP_STATUS_NAVBAR_HEIGHT+45);
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置Cell的动画效果为3D效果
    //设置x和y的初始值为0.1；
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:1 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);

    }];
}
@end
