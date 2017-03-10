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
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = MY_RandomColor;
    [self addSubview:self.imageView];
    self.imageView.image = [UIImage imageNamed:@"icon"];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 140*MY_ScreenWidth/375));
    }];
    
    self.buttonView = [[UIView alloc] init];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    self.buttonView.backgroundColor = MY_RandomColor;
    [self addSubview:self.buttonView];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self.imageView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 44));
    }];
    NSArray *buttontitles = [NSArray arrayWithObjects:@"项目简介",@"成功案例", nil];
    for (int i = 0; i < buttontitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttontitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(16);
        button.tag = 2000 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.buttonView).with.offset(MY_ScreenWidth/buttontitles.count*i);
            make.top.mas_equalTo(self.buttonView);
            make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth/buttontitles.count, 42));
        }];
        if (i == 0) {
            [self buttonAction:button];
        }
    }
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [MY_Util setColorWithInt:0xdddddd];
    [self.buttonView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.buttonView);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 0.5));
        make.bottom.mas_equalTo(self.buttonView);
    }];
    self.selectedLineView = [[UIView alloc] init];
    self.selectedLineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.buttonView addSubview:self.selectedLineView];
    [self.selectedLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.buttonView);
        make.bottom.mas_equalTo(self.buttonView);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth/buttontitles.count, 2));
    }];
    
    UIView *space = [[UIView alloc] init];
    space.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:space];
    [space mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self.buttonView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 5));
    }];

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.backgroundColor = MY_RandomColor;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(space.mas_bottom);
        make.width.mas_equalTo(MY_ScreenWidth);
        make.bottom.mas_equalTo(self);
    }];
    
    self.introView = [[UIView alloc] init];
    [self.scrollView addSubview:self.introView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MY_CourseCustomedDemoCell class] forCellReuseIdentifier:@"CourseCustomedDemoCell"];
    [self.scrollView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MY_ScreenWidth);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(MY_ScreenWidth);
    }];
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    
    
    
}

- (void)buttonAction:(UIButton*)btn {
    [UIView animateWithDuration:0.25 animations:^{
        self.selectedLineView.left = btn.left;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MY_CourseCustomedDemoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CourseCustomedDemoCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
