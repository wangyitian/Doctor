//
//  UITableView+MJRefresh.m
//  YiMei
//
//  Created by 刘玉娇 on 16/5/17.
//  Copyright © 2016年 Xiaolinxiaoli. All rights reserved.
//

#import "UITableView+MJRefresh.h"

@implementation UITableView (MJRefresh)

- (void)addHeaderRefreshTarget:(id)target refreshingAction:(SEL)action {
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setTitle:@"加载中..." forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新..." forState:MJRefreshStatePulling];
    [header setTitle:@"松开立即刷新..." forState:MJRefreshStateWillRefresh];
    [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    
    NSMutableArray *imagesArray = [NSMutableArray array];
    for (int i = 1; i <=95; i++) {
        if (i < 10) {
            [imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_small000%d", i]]];
        } else {
            [imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"loading_small00%d", i]]];
        }
    }
    // 设置普通状态的动画图片
    [header setImages:imagesArray forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:imagesArray forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:imagesArray forState:MJRefreshStateRefreshing];

    self.mj_header =  header;
}

- (void)addFooterRefreshTarget:(id)target refreshingAction:(SEL)action {
    MJRefreshAutoNormalFooter* footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    footer.stateLabel.hidden = YES;
    footer.refreshingTitleHidden = YES;
    self.mj_footer = footer;
}

- (void)headerEndRefreshing {
    [self.mj_header endRefreshing];
}

- (void)footerEndRefreshing {
    [self.mj_footer endRefreshing];
}

- (void)endLoadMoreWithStr:(NSString*)str {
    [self.mj_footer endRefreshing];
    [((MJRefreshAutoNormalFooter*)self.mj_footer) setTitle:str forState:MJRefreshStateNoMoreData];
    ((MJRefreshAutoNormalFooter*)self.mj_footer).stateLabel.hidden = NO;
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetLoadMoreStatus {
    [self.mj_footer resetNoMoreData];
}
@end
