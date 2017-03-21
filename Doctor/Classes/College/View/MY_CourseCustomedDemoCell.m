//
//  MY_CourseCustomedDemoCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseCustomedDemoCell.h"
#import "MY_CustomedCourseModel.h"
@interface MY_CourseCustomedDemoCell ()
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UILabel *courseNameLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;

@property (nonatomic, strong) UIView *detailView;
@property (nonatomic, strong) MY_CustomedCourseModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
@implementation MY_CourseCustomedDemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = MY_RandomColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 44)];
    self.mainView.backgroundColor = MY_RandomColor;
    [self.contentView addSubview:self.mainView];
    
    self.detailView = [[UIView alloc] init];
    self.detailView.backgroundColor = MY_RandomColor;
    [self addSubview:self.detailView];
    
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    _model = (MY_CustomedCourseModel*)object;
    _indexPath = indexpath;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openAction)];
    [self.mainView addGestureRecognizer:tap];
    
    self.detailView.frame = CGRectMake(0, self.mainView.bottom, MY_ScreenWidth, 156);

    if (_model.isOpen) {
        self.detailView.hidden = NO;
    } else {
        self.detailView.hidden = YES;
    }
}

- (void)openAction {
    _model.isOpen = !_model.isOpen;
    if (self.isOpenBlock) {
        self.isOpenBlock(_indexPath, _model.isOpen);
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    MY_CustomedCourseModel *model = (MY_CustomedCourseModel*)object;
    
    if (model.isOpen) {
        return 200;
    } else {
        return 44;
    }
}

@end
