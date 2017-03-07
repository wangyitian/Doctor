//
//  MY_CourseCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseCell.h"
#import "MY_CourseModel.h"
@interface MY_CourseCell ()
@property (nonatomic, strong) UIImageView *courseImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *roomTypeLabel;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UILabel *introLabel;

@end

@implementation MY_CourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CGFloat imageH = 140*MY_ScreenWidth/375;
    self.courseImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.courseImageView];
    [self.courseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, imageH));
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@15);
        make.top.mas_equalTo(self.courseImageView.mas_bottom).with.offset(18);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];
    
    self.roomTypeLabel = [[UILabel alloc] init];
    self.roomTypeLabel.font = MY_Font(14);
    self.roomTypeLabel.textColor = [MY_Util setColorWithInt:0x68d6a7];
    self.roomTypeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.roomTypeLabel];
    [self.roomTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-15);
        make.top.mas_equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];
    
    self.buttonView = [[UIView alloc] init];
    [self.contentView addSubview:self.buttonView];
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self.roomTypeLabel).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 20));
    }];
    
    self.introLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.buttonView.bottom + 10, MY_ScreenWidth - 15*2, 0)];
    self.introLabel.numberOfLines = 4;
    self.introLabel.font = MY_Font(14);
    self.introLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self.contentView addSubview:self.introLabel];
    [self.introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@15);
        make.right.mas_equalTo(self).with.offset(-15);
        make.top.mas_equalTo(self.buttonView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(100);
    }];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_CourseModel *model = (MY_CourseModel*)object;
    [self.courseImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImage] placeholderImage:nil];
    
    self.titleLabel.text = model.courseTitle;
    
    self.roomTypeLabel.text = model.courseRoomType;
    
    NSInteger count = model.detailArray.count;
    for (int i = 0; i < count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:model.detailArray[i][@"title"] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
        button.titleLabel.font = MY_Font(12);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 10;
        button.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
        button.layer.borderWidth = 1;
        CGFloat buttonW = 62;
        CGFloat space = (MY_ScreenWidth - buttonW*count - 15*2)/(count - 1);
        CGFloat buttonX = 15 + (62+space)*i;
        button.frame = CGRectMake(buttonX, 0, buttonW, 20);
        button.tag = 2000 + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:button];
    }
    
    [self.introLabel getLabelHeightWithSpaceHeight:10 withFont:14 withStr:model.detailArray[0][@"detail"] withTextColor:[MY_Util setColorWithInt:0x666666] withLabelWidth:MY_ScreenWidth-30];
}

- (void)buttonAction:(UIButton*)btn {
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 175 + 140*MY_ScreenWidth/375;
}

@end
