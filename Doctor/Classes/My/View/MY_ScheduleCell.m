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
    self.circleImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.circleImageView];
    [self.circleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@38);
        make.top.mas_equalTo(self).with.offset(2);
        make.size.mas_equalTo(CGSizeMake(12, 13));
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.circleImageView);
        make.width.mas_equalTo(@1);
        make.top.mas_equalTo(self.circleImageView.mas_bottom).with.offset(-1);
        make.bottom.mas_equalTo(self);
    }];
    
    self.scheduleLabel = [[UILabel alloc] init];
    self.scheduleLabel.textColor = [MY_Util setColorWithInt:0x666666];
    self.scheduleLabel.font = MY_Font(15);
    [self.contentView addSubview:self.scheduleLabel];
    [self.scheduleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.circleImageView.mas_right).with.offset(15);
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(75, 15));
    }];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textColor = self.scheduleLabel.textColor;
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
    self.timeLabel.text = model.time;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    MY_ScheduleModel *model = (MY_ScheduleModel*)object;
    return 59;
}

@end
