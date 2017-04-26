//
//  MY_CourseCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseCell.h"
#import "MY_CourseModel.h"
#define TAG_FOR_BUTTON 2000
@interface MY_CourseCell ()
@property (nonatomic, strong) UIImageView *courseImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *roomTypeLabel;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) MY_CourseModel *model;

@end

@implementation MY_CourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self.contentView addSubview:line];
    
    CGFloat imageH = 140*MY_ScreenWidth/(375-30);
    self.courseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, line.bottom+10, MY_ScreenWidth-30, imageH)];
    [self.contentView addSubview:self.courseImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.courseImageView.bottom+18, 200, 15)];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.titleLabel];
    
    self.roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(MY_ScreenWidth-15-150, self.titleLabel.top, 150, 15)];
    self.roomTypeLabel.font = MY_Font(14);
    self.roomTypeLabel.textColor = [MY_Util setColorWithInt:0x68d6a7];
    self.roomTypeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.roomTypeLabel];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.roomTypeLabel.bottom+12, MY_ScreenWidth, 20)];
    [self.contentView addSubview:self.buttonView];
    NSArray *buttonTitles = [NSArray arrayWithObjects:@"课程介绍",@"报名条件",@"进修时间", nil];
    NSInteger count = buttonTitles.count;
    for (int i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(12);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 10;
        button.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
        button.layer.borderWidth = 1;
        CGFloat buttonW = 62;
        CGFloat space = 20;
        CGFloat buttonX = 15 + (62+space)*i;
        button.frame = CGRectMake(buttonX, 0, buttonW, 20);
        button.tag = TAG_FOR_BUTTON + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:button];
    }
    
    self.introLabel = [[UILabel alloc] init];
    self.introLabel.numberOfLines = 4;
    self.introLabel.font = MY_Font(13);
    self.introLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self.contentView addSubview:self.introLabel];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    _model = (MY_CourseModel*)object;
    MY_CourseModel *model = (MY_CourseModel*)object;
    
    [self.courseImageView sd_setImageWithURL:[NSURL URLWithString:model.file] placeholderImage:[UIImage imageNamed:@"default"]];
    
    self.titleLabel.text = model.name;
    self.titleLabel.frame = CGRectMake(15, self.courseImageView.bottom+18, [model.name sizeWithFont:MY_Font(15)].width, 15);
    self.roomTypeLabel.text = model.type;
   
    self.introLabel.text = model.x_introduce;
    CGFloat height = [self.introLabel getLabelHeightWithSpaceHeight:10 withFont:13 withStr:model.x_introduce withTextColor:[MY_Util setColorWithInt:0x666666] withLabelWidth:MY_ScreenWidth-30];
    if (height > 93) {
        height = 93;
    }
    
    self.introLabel.frame = CGRectMake(15, self.buttonView.bottom + 10, MY_ScreenWidth - 15*2, height);
}

- (void)buttonAction:(UIButton*)btn {
    if (btn.tag-TAG_FOR_BUTTON == 0) {
        CGFloat height = [self.introLabel getLabelHeightWithSpaceHeight:10 withFont:13 withStr:self.model.x_introduce withTextColor:[MY_Util setColorWithInt:0x666666] withLabelWidth:MY_ScreenWidth-30];
        if (height > 93) {
            height = 93;
        }
        self.introLabel.frame = CGRectMake(15, self.buttonView.bottom + 10, MY_ScreenWidth - 15*2, height);
    } else if (btn.tag-TAG_FOR_BUTTON == 1) {
        CGFloat height = [self.introLabel getLabelHeightWithSpaceHeight:10 withFont:13 withStr:self.model.x_condition withTextColor:[MY_Util setColorWithInt:0x666666] withLabelWidth:MY_ScreenWidth-30];
        if (height > 93) {
            height = 93;
        }
        self.introLabel.frame = CGRectMake(15, self.buttonView.bottom + 10, MY_ScreenWidth - 15*2, height);
    }else if (btn.tag-TAG_FOR_BUTTON == 2) {
        CGFloat height = [self.introLabel getLabelHeightWithSpaceHeight:10 withFont:13 withStr:self.model.a_time withTextColor:[MY_Util setColorWithInt:0x666666] withLabelWidth:MY_ScreenWidth-30];
        if (height > 93) {
            height = 93;
        }
        self.introLabel.frame = CGRectMake(15, self.buttonView.bottom + 10, MY_ScreenWidth - 15*2, height);
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 175 + 140*MY_ScreenWidth/(375-30) + 5 + 25;
}

@end
