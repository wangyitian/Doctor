//
//  MY_ScheduleCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/6.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ScheduleCell.h"
@interface MY_ScheduleCell ()
@property (nonatomic, strong) UIImageView *circleImageView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *scheduleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end
@implementation MY_ScheduleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(38, 2, 12, 12)];
    [self.contentView addSubview:self.circleImageView];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.contentView addSubview:self.lineView];
    
    self.scheduleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.circleImageView.right+15, 0, 75, 15)];
    self.scheduleLabel.textColor = [MY_Util setColorWithInt:0x666666];
    self.scheduleLabel.font = MY_Font(15);
    [self.contentView addSubview:self.scheduleLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textColor = self.scheduleLabel.textColor;
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = MY_Font(14);
    [self.contentView addSubview:self.detailLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = self.scheduleLabel.textColor;
    self.timeLabel.font = MY_Font(12);
    [self.contentView addSubview:self.timeLabel];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_ScheduleModel *model = (MY_ScheduleModel*)object;
    self.circleImageView.image = model.status?[UIImage imageNamed:@"schedule_circle"]:[UIImage imageNamed:@"schedule_circle_empty"];
    
    self.scheduleLabel.text = model.name;
    self.detailLabel.text = model.detail;
    CGSize size = [model.detail sizeWithFont:MY_Font(14) andSize:CGSizeMake(MY_ScreenWidth-140-15, MAXFLOAT)];
    self.detailLabel.frame = CGRectMake(140, 0, MY_ScreenWidth-140-15, size.height);
    
    self.timeLabel.text = model.time;
    self.timeLabel.frame = CGRectMake(self.detailLabel.left, self.detailLabel.bottom+10, MY_ScreenWidth-140-15, 12);
    
    if (model.isFirst && model.isLast) {
        self.lineView.hidden = YES;
    } else {
        if (model.isFirst) {
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.circleImageView);
                make.top.mas_equalTo(self.circleImageView);
                make.width.mas_equalTo(@1);
                make.bottom.mas_equalTo(self);
            }];
        } else if (model.isLast) {
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.circleImageView);
                make.top.mas_equalTo(self);
                make.width.mas_equalTo(@1);
                make.bottom.mas_equalTo(self.circleImageView);
            }];
        } else {
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.circleImageView);
                make.top.mas_equalTo(self);
                make.width.mas_equalTo(@1);
                make.bottom.mas_equalTo(self);
            }];
        }
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    MY_ScheduleModel *model = (MY_ScheduleModel*)object;
    
    CGSize size = [model.detail sizeWithFont:MY_Font(14) andSize:CGSizeMake(MY_ScreenWidth-140-15, MAXFLOAT)];
    
    return 70 + (size.height - 15);
}

@end
