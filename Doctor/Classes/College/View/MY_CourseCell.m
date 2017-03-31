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
    self.courseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, imageH)];
    [self.contentView addSubview:self.courseImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.courseImageView.bottom+18, 150, 15)];
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
    
    self.introLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.buttonView.bottom + 10, MY_ScreenWidth - 15*2, 100)];
    self.introLabel.numberOfLines = 4;
    self.introLabel.font = MY_Font(14);
    self.introLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self.contentView addSubview:self.introLabel];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_CourseModel *model = (MY_CourseModel*)object;
    [self.courseImageView sd_setImageWithURL:[NSURL URLWithString:model.courseImage] placeholderImage:[UIImage imageNamed:@"default"]];
    
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
        button.tag = TAG_FOR_BUTTON + i;
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
