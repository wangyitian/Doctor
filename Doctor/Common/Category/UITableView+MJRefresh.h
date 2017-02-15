//
//  UITableView+MJRefresh.h
//  YiMei
//
//  Created by 刘玉娇 on 16/5/17.
//  Copyright © 2016年 Xiaolinxiaoli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (MJRefresh)

- (void)addHeaderRefreshTarget:(id)target refreshingAction:(SEL)action;
- (void)addFooterRefreshTarget:(id)target refreshingAction:(SEL)action;

- (void)headerEndRefreshing;
- (void)footerEndRefreshing;

- (void)endLoadMoreWithStr:(NSString*)str;
- (void)resetLoadMoreStatus;

@end
