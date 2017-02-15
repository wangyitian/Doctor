//
//  MY_TableViewController.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseController.h"

@interface MY_TableViewController : MY_BaseController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *sections;
/**
 * 子类需要重写该方法
 *
 *  @param object 传入item
 *
 *  @return 返回cell class
 */
- (Class)cellClassForObject:(id)object;

/**
 *  是否添加上拉、下拉
 *
 *  @param isAddHeaderRefresh 上拉 (YES则需要重写headerRereshing)
 *  @param isAddFooterRefresh 下拉 (YES则需要重写footerRereshing)
 */
- (void)addHeaderRefresh:(BOOL)isAddHeaderRefresh footerRefresh:(BOOL)isAddFooterRefresh;

/**
 *  如果addHeaderRefresh isAddHeaderRefresh参数为YES，则需要子类重新该方法实现下拉的操作
 */
- (void)headerRereshing;

/**
 *  如果addHeaderRefresh isAddFooterRefresh参数为YES，则需要子类重新该方法实现上拉的操作
 */
- (void)footerRereshing;

@end
