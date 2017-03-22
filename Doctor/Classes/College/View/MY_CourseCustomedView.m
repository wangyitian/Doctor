//
//  MY_CourseCustomedView.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/8.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseCustomedView.h"
#import "MY_CourseCustomedDemoCell.h"
#import "MY_CustomedCourseModel.h"
#define TAG_FOR_BUTTON  2000
@interface MY_CourseCustomedView () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIView *selectedLineView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *introView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MY_CourseCustomedView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 140*MY_ScreenWidth/375)];
    self.imageView.backgroundColor = MY_RandomColor;
    [self addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"icon"];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageView.bottom, MY_ScreenWidth, 44)];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    self.buttonView.backgroundColor = MY_RandomColor;
    [self addSubview:self.buttonView];

    NSArray *buttontitles = [NSArray arrayWithObjects:@"项目简介",@"成功案例", nil];
    for (int i = 0; i < buttontitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttontitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(16);
        button.tag = TAG_FOR_BUTTON + i;
        button.frame = CGRectMake(MY_ScreenWidth/buttontitles.count*i, 0, MY_ScreenWidth/buttontitles.count, 42);
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:button];
        if (i == 0) {
            [self buttonAction:button];
        }
    }
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonView.height-0.5, MY_ScreenWidth, 0.5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xdddddd];
    [self.buttonView addSubview:line];

    self.selectedLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonView.height-2, MY_ScreenWidth/buttontitles.count, 2)];
    self.selectedLineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.buttonView addSubview:self.selectedLineView];
    
    UIView *space = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonView.bottom, MY_ScreenWidth, 5)];
    space.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:space];

    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, space.bottom, MY_ScreenWidth, MY_ScreenHeight-space.bottom-MY_APP_STATUS_NAVBAR_HEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    self.introView = [[UIView alloc] init];
    [self.scrollView addSubview:self.introView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(MY_ScreenWidth, 0, MY_ScreenWidth, self.scrollView.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor grayColor];
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MY_CourseCustomedDemoCell class] forCellReuseIdentifier:@"CourseCustomedDemoCell"];
    [self.scrollView addSubview:self.tableView];
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width*2, self.scrollView.height);
    [self.tableView reloadData];
}

- (void)buttonAction:(UIButton*)btn {
    [UIView animateWithDuration:0.25 animations:^{
        self.selectedLineView.left = btn.left;
        [self.scrollView scrollRectToVisible:CGRectMake((btn.tag-TAG_FOR_BUTTON)*MY_ScreenWidth, 0, MY_ScreenWidth, self.scrollView.height) animated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ((NSArray*)self.dataDic[@"models"]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MY_CourseCustomedDemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCustomedDemoCell" forIndexPath:indexPath];
    [cell setObject:((NSArray*)self.dataDic[@"models"])[indexPath.row] indexPath:indexPath];
    cell.isOpenBlock = ^(NSIndexPath *indexPath, BOOL isOpen) {
        ((MY_CustomedCourseModel*)((NSArray*)self.dataDic[@"models"])[indexPath.row]).isOpen = isOpen;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MY_CourseCustomedDemoCell tableView:tableView rowHeightForObject:((NSArray*)self.dataDic[@"models"])[indexPath.row]];
}

@end
