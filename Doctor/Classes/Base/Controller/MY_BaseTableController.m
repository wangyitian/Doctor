//
//  MY_BaseTableController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseTableController.h"
#import "MY_BaseCell.h"
#import "UITableView+MJRefresh.h"
#import <objc/runtime.h>
@interface MY_BaseTableController ()

@end

@implementation MY_BaseTableController

#pragma mark - 生命周期
- (instancetype)init {
    if (self = [super init]) {
        self.dataSource = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
}

#pragma mark - 实例化tableview
- (void)initTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_ScreenHeight) style:[self getTableViewStyle]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
//    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
}

#pragma mark - tableview样式，子类可以重写
- (UITableViewStyle)getTableViewStyle {
    return UITableViewStylePlain;
}

#pragma mark - 是否增加上拉加载和下拉刷新
- (void)addHeaderRefresh:(BOOL)isAddHeaderRefresh footerRefresh:(BOOL)isAddFooterRefresh {
    if (isAddHeaderRefresh) {
        [self.tableView addHeaderRefreshTarget:self refreshingAction:@selector(headerRereshing)];
    }
    if (isAddFooterRefresh) {
        [self.tableView addFooterRefreshTarget:self refreshingAction:@selector(footerRereshing)];
    }
}

#pragma mark - 上拉加载和下拉刷新触发的方法，子类需要重写
- (void)headerRereshing {
    
}

- (void)footerRereshing {
    
}

#pragma mark - 网络请求相关代理方法
- (void)hideLoadingAndMJ {
    [self hideLoading];
    [self.tableView footerEndRefreshing];
    [self.tableView headerEndRefreshing];
}


#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.dataSource objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id object = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    Class cellClass = [self cellClassForObject:object indexPath:indexPath];
    const char* className = class_getName(cellClass);
    NSString* identifier = [[NSString alloc] initWithBytesNoCopy:(char*)className length:strlen(className) encoding:NSASCIIStringEncoding freeWhenDone:NO];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (nil == cell) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [((MY_BaseCell*)cell) setObject:object indexPath:indexPath];
    ((MY_BaseCell*)cell).delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id object = [[self.dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    Class cls = [self cellClassForObject:object indexPath:indexPath];
    return [cls tableView:tableView rowHeightForObject:object];
}

//需要重写
- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath*)indexPath {
    return [NSObject class];
}

@end
